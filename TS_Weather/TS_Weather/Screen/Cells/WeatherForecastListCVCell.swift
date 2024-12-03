//
//  WeatherForecastListCVCell.swift
//  TS_Weather
//
//  Created by siyeon park on 12/3/24.
//

import UIKit
import SnapKit

final class WeatherForecastListCVCell: UICollectionViewCell, ReuseIdentifying {
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
}

// MARK: - Setup UI

extension WeatherForecastListCVCell {
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
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForecastTVCell.reuseIdentifier, for: indexPath) as? WeatherForecastTVCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
