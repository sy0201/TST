//
//  WeatherForecastListCVCell.swift
//  TS_Weather
//
//  Created by siyeon park on 12/3/24.
//

import UIKit
import SnapKit

final class WeatherForecastListCVCell: UICollectionViewCell, ReuseIdentifying {
    private var forecastList: [ForecastWeather] = []
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = true
        tableView.isScrollEnabled = true
        
        return tableView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateForecastList(_ list: [ForecastWeather]) {
        self.forecastList = list
        self.tableView.reloadData()
    }
}

// MARK: - Private setup UI Methods

private extension WeatherForecastListCVCell {
    func setupUI() {
        addSubview(tableView)
    }
    
    func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(WeatherForecastTVCell.self, forCellReuseIdentifier: WeatherForecastTVCell.reuseIdentifier)
    }
}

// MARK: - Tableview Method

extension WeatherForecastListCVCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("forecastList.count \(forecastList.count)")
        return forecastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForecastTVCell.reuseIdentifier, for: indexPath) as? WeatherForecastTVCell else {
            return UITableViewCell()
        }

        let forecast = forecastList[indexPath.row]
        cell.dateLabel.text = forecast.date
        cell.temperatureLabel.text = "\(forecast.main.temp)°C"
        
        print("forecast \(forecast)")

        return cell
    }
}
