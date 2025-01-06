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
        imageView.image = UIImage(named: "pokemonBall")
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
    
    let horisontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    let numberTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = "No."
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = "??"
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = "??"
        return label
    }()
    
    let typeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    let typeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.text = "타입 :"
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.text = "??"
        return label
    }()
    
    let heightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    let heightTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.text = "키 :"
        return label
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.text = "??"
        return label
    }()
    
    let weightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    let weightTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.text = "몸무게 :"
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
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
        let imageUrl = URL(string: detail.sprites.frontDefault)
        imageView.kf.setImage(with: imageUrl)
        
        numberLabel.text = "\(detail.id)"
        
        let pokeName = String(detail.name)
        let koreanName = Enum.PokemonTranslator.getKoreanName(for: pokeName)
        nameLabel.text = koreanName
        
        let pokeType = detail.types.map { type in
            Enum.PokemonTypeName.getPokeType(type.type.name)
        }
        typeLabel.text = "\(pokeType.joined(separator: ", "))"
        heightLabel.text = "\(detail.height) m"
        weightLabel.text = "\(detail.weight) kg"
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

        labelStackView.addArrangedSubViews([horisontalStackView,
                                            typeStackView,
                                            heightStackView,
                                            weightStackView])
        horisontalStackView.addArrangedSubViews([numberTitleLabel, numberLabel, nameLabel])
        typeStackView.addArrangedSubViews([typeTitleLabel, typeLabel])
        heightStackView.addArrangedSubViews([heightTitleLabel, heightLabel])
        weightStackView.addArrangedSubViews([weightTitleLabel, weightLabel])
    }
    
    func setupConstraint() {
        baseView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(baseView.snp.top).offset(10)
            make.centerX.equalTo(baseView.snp.centerX)
            make.size.equalTo(200)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(baseView)
            make.bottom.equalTo(baseView.snp.bottom).offset(-20)
        }
    }
}
