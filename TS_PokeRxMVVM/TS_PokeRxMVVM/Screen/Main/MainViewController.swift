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
    private let viewModel: MainViewModel
    private let disposebag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.backgroundColor = .darkRed
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)
        collectionView.register(PokeListCollectionViewCell.self, forCellWithReuseIdentifier: PokeListCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    init(viewModel: MainViewModel) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true // MainViewController가 나타날 때 NavigationBar 숨기기
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      navigationController?.isNavigationBarHidden = false // MainViewController가 사라질 때 NavigationBar 나타내기
    }
}

// MARK: - bind Method

private extension MainViewController {
    func bindViewModel() {
        viewModel.refreshPokemonList()
        viewModel.pokeList
            .subscribe(onNext: { [weak self] pokeList in
                if pokeList.isEmpty {
                    // 네트워크 오류시 빈 목록 처리
                    self?.showNoNetworkAlert()
                } else {
                    self?.applySnapshot(pokeList: pokeList)
                }
            })
            .disposed(by: disposebag)
        
        collectionView.rx.willDisplayCell
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] cell, indexPath in
                guard let self = self,
                      let totalItems = self.dataSource?.snapshot().itemIdentifiers.count else { return }
                
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
        collectionView.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self,
                      let item = self.dataSource?.itemIdentifier(for: indexPath) else { return }
                
                switch item {
                case .pokeList(let result):
                    let detailViewModel = DetailViewModel(repository: self.viewModel.repository, pokemonID: result.id)
                    let detailVC = DetailViewController(viewModel: detailViewModel)
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }
            })
            .disposed(by: disposebag)
    }
    
    // 네트워크가 없을 때 사용자에게 알림을 표시하는 함수
    func showNoNetworkAlert() {
        let alert = UIAlertController(title: "네트워크가 없습니다.", message: "네트워크 연결을 다시 시도하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
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
