//
//  WeatherViewController.swift
//  TS_Weather
//
//  Created by siyeon park on 12/3/24.
//

import UIKit

final class WeatherViewController: UIViewController {
    let mainView = MainView()

    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
        // 셀 연결
        mainView.collectionView.register(CurrentLocationWeatherCVCell.self, forCellWithReuseIdentifier: CurrentLocationWeatherCVCell.reuseIdentifier)
        mainView.collectionView.register(WeatherImageCVCell.self, forCellWithReuseIdentifier: WeatherImageCVCell.reuseIdentifier)
        mainView.collectionView.register(WeatherForecastListCVCell.self, forCellWithReuseIdentifier: WeatherForecastListCVCell.reuseIdentifier)
    }
}

// MARK: - CollectionView Method

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentLocationWeatherCVCell.reuseIdentifier, for: indexPath) as? CurrentLocationWeatherCVCell else {
                return UICollectionViewCell()
            }
            
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherImageCVCell.reuseIdentifier, for: indexPath) as? WeatherImageCVCell else {
                return UICollectionViewCell()
            }
            
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherForecastListCVCell.reuseIdentifier, for: indexPath) as? WeatherForecastListCVCell else {
                return UICollectionViewCell()
            }
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width, height: 150)
        case 1:
            return CGSize(width: UIScreen.main.bounds.width, height: 100)
        case 2:
            return CGSize(width: UIScreen.main.bounds.width, height: 300)
        default:
            return CGSize(width: UIScreen.main.bounds.width, height: 300)
        }
    }
}
