//
//  WeatherCollectionViewController.swift
//  Weather
//
//  Created by Vlad on 04.08.2021.
//

import UIKit

class WeatherViewController: UIViewController {

    var city: String?
    lazy var service = WeatherAPIService()

    override func viewDidLoad() {
        super.viewDidLoad()

        service.getWeather(city: city ?? "Moscow")
    }
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
        cell.weatherLabel.text = "30 Cº"
        cell.timeLabel.text = "04.07.2021 14:04"
        return cell
    }
}
