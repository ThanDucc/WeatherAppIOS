//
//  ViewController.swift
//  WeatherApp
//
//  Created by ThanDuc on 07/05/2024.
//

import UIKit

class HomeScreen: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionIconImage: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let numberOfCell = 12
    
    private var viewModel = HomeScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadData()
    }
    
    func setupView() {
        indicator.startAnimating()
        collectionView.contentInset.left = 16
        collectionView.contentInset.right = 16
    }

    private func updateUI() {
        let weatherNib = UINib(nibName: WeatherDailyCell.identifier, bundle: nil)
        collectionView.register(weatherNib, forCellWithReuseIdentifier: WeatherDailyCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addressLabel.text = Constants.address.capitalized
        
        guard let weather = viewModel.weather else { return }
        conditionLabel.text = weather.current.condition.text
        temperatureLabel.text = String(weather.current.tempC) + " °C"
        
        viewModel.loadImage(string: weather.current.condition.icon) { [weak self] image in
            guard let self = self else { return }
            self.conditionIconImage.image = image
        }
    }
    
    private func loadData() {
        viewModel.getWeatherInfor(completion: {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.updateUI()
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        })
    }

}

extension HomeScreen: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherDailyCell.identifier, for: indexPath) as? WeatherDailyCell else { return UICollectionViewCell() }
        
        if let hour = viewModel.weather?.forecast.forecastday.first?.hour[indexPath.row * 2] {
            cell.configCell(hour: hour)
        }
        
        if let icon = viewModel.weather?.forecast.forecastday[0].hour[indexPath.row * 2].condition.icon {
            viewModel.loadImage(string: icon) { image in
                cell.configCell(image: image)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenWidth = UIScreen.main.bounds.width - 40
        return CGSize(width: screenWidth/3.4, height: 170)
    }
    
}
