//
//  PokeListCollectionViewCell.swift
//  TS_PokeRxMVVM
//
//  Created by t2023-m0019 on 12/31/24.
//

import UIKit
import Kingfisher

final class PokeListCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.layer.cornerRadius = 20
        //imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(id: Int) {
        var imageId = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
        imageView.kf.setImage(with: URL(string: imageId)) { result in
            switch result {
            case .success(let value):
                print("Image loaded successfully: \(value.image)")
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
    }
}

private extension PokeListCollectionViewCell {
    func setupUI() {
        layer.masksToBounds = true
        layer.cornerRadius = 10
        self.backgroundColor = .cellBackground
        addSubview(imageView)
    }
    
    func setupConstraint() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(120)
        }
    }
}
