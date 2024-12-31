//
//  DetailView.swift
//  TS_PokeRxMVVM
//
//  Created by t2023-m0019 on 12/31/24.
//

import UIKit
import Kingfisher
import SnapKit

final class DetailView: UIView {
    let baseView = UIView()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with detail: PokeDetail) {
        imageView.kf.setImage(with: URL(string: detail.frontDefault))
        nameLabel.text = detail.name
        typeLabel.text = detail.types.map { $0.type.name }.joined(separator: ", ")
        heightLabel.text = "키: \(detail.height) m"
        weightLabel.text = "몸무게: \(detail.weight) kg"
       
    }
}

private extension DetailView {
    func setupUI() {
        baseView.layer.cornerRadius = 15
        baseView.layer.masksToBounds = true
        baseView.backgroundColor = .darkRed
        
        self.backgroundColor = .mainRed
        addSubview(baseView)
        baseView.addSubViews([imageView, labelStackView])

        labelStackView.addArrangedSubViews([nameLabel,
                                            typeLabel,
                                            heightLabel,
                                            weightLabel])
    }
    
    func setupConstraint() {
        baseView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(baseView.snp.top).offset(10)
            make.width.equalToSuperview().multipliedBy(1/3)
            make.height.equalTo(200)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(baseView)
            make.bottom.equalTo(baseView.snp.bottom).offset(-20)
        }
    }
}
