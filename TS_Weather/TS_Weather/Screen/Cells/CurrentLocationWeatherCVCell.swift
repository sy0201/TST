//
//  CurrentLocationWeatherCVCell.swift
//  TS_Weather
//
//  Created by siyeon park on 12/3/24.
//

import UIKit
import SnapKit

final class CurrentLocationWeatherCVCell: UICollectionViewCell, ReuseIdentifying {
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.textColor = .systemBackground
        label.text = "서울특별시"
        return label
    }()
    
    let tempStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .medium)
        label.textColor = .systemBackground
        label.text = "22"
        return label
    }()
    
    var celsiusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .regular)
        label.textColor = .systemBackground
        label.text = "℃"
        return label
    }()

    let subStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    var minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemBackground
        label.text = "최저-4℃"
        return label
    }()
    
    var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemBackground
        label.text = "최고4℃"
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
}

// MARK: - Setup UI

extension CurrentLocationWeatherCVCell {
    func setupUI() {
        self.backgroundColor = .clear
        addSubview(mainStackView)
        mainStackView.addArrangedSubViews([locationLabel,
                                           tempStackView,
                                           subStackView])
        tempStackView.addArrangedSubViews([temperatureLabel, celsiusLabel])
        subStackView.addArrangedSubViews([minTemperatureLabel, maxTemperatureLabel])
    }
    
    func setupConstraint() {
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview()
        }
    }
}
