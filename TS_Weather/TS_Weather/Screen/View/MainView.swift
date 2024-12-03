//
//  MainView.swift
//  TS_Weather
//
//  Created by siyeon park on 12/3/24.
//

import UIKit
import SnapKit

final class MainView: UIView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 50
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - setupUI Methods

extension MainView {
    func setupUI() {
        collectionView.backgroundColor = .black
        addSubview(collectionView)
    }
    
    func setupConstraint() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
