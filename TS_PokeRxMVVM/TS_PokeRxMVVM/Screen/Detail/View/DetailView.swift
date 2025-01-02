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
        imageView.contentMode = .scaleAspectFit
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
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
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
        
        numberLabel.text = "No. \(detail.id)"
        
        let pokeName = String(detail.name)
        let koreanName = Enum.PokemonTranslator.getKoreanName(for: pokeName)
        nameLabel.text = koreanName
        
        let pokeType = detail.types.map { type in
            Enum.PokemonTypeName.getPokeType(type.type.name)
        }
        typeLabel.text = "타입: \(pokeType.joined(separator: ", "))"
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

        labelStackView.addArrangedSubViews([horisontalStackView,
                                            typeLabel,
                                            heightLabel,
                                            weightLabel])
        horisontalStackView.addArrangedSubViews([numberLabel, nameLabel])
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
