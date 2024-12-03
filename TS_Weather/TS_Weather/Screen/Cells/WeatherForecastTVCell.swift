//
//  WeatherForecastTVCell.swift
//  TS_Weather
//
//  Created by siyeon park on 12/3/24.
//

import UIKit
import SnapKit

final class WeatherForecastTVCell: UITableViewCell, ReuseIdentifying {
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemBackground
        label.text = "2024-12-03 18:00:00"
        return label
    }()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemBackground
        label.text = "22.5℃"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI

extension WeatherForecastTVCell {
    func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        addSubViews([dateLabel, temperatureLabel])
    }
    
    func setupConstraint() {
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
    }
}
