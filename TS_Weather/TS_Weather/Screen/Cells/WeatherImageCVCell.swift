//
//  WeatherImageCVCell.swift
//  TS_Weather
//
//  Created by siyeon park on 12/3/24.
//

import UIKit
import SnapKit

final class WeatherImageCVCell: UICollectionViewCell, ReuseIdentifying {
    lazy var weatherImg = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWeatherIcon(iconURL: String) {
        if let url = URL(string: iconURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.weatherImg.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}

// MARK: - Private setup UI Methods

private extension WeatherImageCVCell {
    func setupUI() {
        weatherImg.contentMode = .scaleAspectFit
        addSubview(weatherImg)
    }
    
    func setupConstraint() {
        weatherImg.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
}
