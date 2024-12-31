//
//  ViewController.swift
//  TS_PokeRxMVVM
//
//  Created by t2023-m0019 on 12/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

fileprivate enum Section: Hashable {
    case vertical
}

fileprivate enum Item: Hashable {
    case pokeList(Result)
}

final class MainViewController: UIViewController {
    private let viewModel: PokeViewModel
    private let disposebag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.backgroundColor = .darkRed
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)
        collectionView.register(PokeListCollectionViewCell.self, forCellWithReuseIdentifier: PokeListCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    init(viewModel: PokeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setDataSource()
        bindViewModel()
        bindView()
    }
}

// MARK: - bind Method

private extension MainViewController {
    func bindViewModel() {
        // 포켓몬 리스트 데이터 요청 로드(
        viewModel.refreshPokemonList()
        
        // 포켓몬 리스트 데이터 바인드
        viewModel.pokeList
            .subscribe(onNext: { [weak self] pokeList in
                print("PokeList Updated: \(pokeList)")
                self?.applySnapshot(pokeList: pokeList)
            })
            .disposed(by: disposebag)
        
        // 스크롤 감지를 위한 바인딩 추가
        collectionView.rx.willDisplayCell
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] cell, indexPath in
                guard let self = self,
                      let totalItems = self.dataSource?.snapshot().itemIdentifiers.count else { return }
                
                // 마지막 아이템으로부터 5개 셀 전에 도달하면 추가 로드
                if indexPath.item == totalItems - 5 {
                    self.viewModel.loadMorePokemon()
                }
            })
            .disposed(by: disposebag)
    }
    
    func applySnapshot(pokeList: [Result]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        let items = pokeList.map { Item.pokeList($0) }
        
        let section = Section.vertical
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        
        self.dataSource?.apply(snapshot)
    }
    
    func bindView() {
        collectionView.rx.itemSelected.bind { indexPath in
            print(indexPath)
            let item = self.dataSource?.itemIdentifier(for: indexPath)
            switch item {
            case .pokeList(let detail):
                print("detail")
                let viewController = DetailViewController(viewModel: self.viewModel)
                self.viewModel.loadPokeDetail(id: detail.id)
                self.navigationController?.pushViewController(viewController, animated: true)
            default:
                print("default")
            }
        }.disposed(by: disposebag)
    }
}

// MARK: - UI Method

private extension MainViewController {
    func setupUI() {
        self.view.backgroundColor = .mainRed
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 14
                
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .vertical:
                return self?.createMainSection()
            case nil:
                return self?.createMainSection()
            }
        }, configuration: config)
    }
    
    func createMainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(153))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        section.boundarySupplementaryItems = [header]

        return section
    }
    
    func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .pokeList(let pokeData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeListCollectionViewCell.reuseIdentifier, for: indexPath) as? PokeListCollectionViewCell
                
                cell?.configure(id: pokeData.id)
                return cell
            }
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView
            
            header?.configure()
            return header
        }
    }
}
