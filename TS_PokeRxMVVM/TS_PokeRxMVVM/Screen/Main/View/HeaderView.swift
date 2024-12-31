//
//  HeaderView.swift
//  TS_PokeRxMVVM
//
//  Created by t2023-m0019 on 12/31/24.
//

import UIKit
import SnapKit

final class HeaderView: UICollectionReusableView, ReuseIdentifying {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
    
    func configure() {
        imageView.image = UIImage(named: "pokemonBall")
    }
}

private extension HeaderView {
    func setupUI() {
        self.backgroundColor = .mainRed
        addSubview(imageView)
    }
    
    func setupConstraint() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
}
