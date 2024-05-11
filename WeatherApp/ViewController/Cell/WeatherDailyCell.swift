//
//  WeatherDailyCell.swift
//  WeatherApp
//
//  Created by ThanDuc on 11/05/2024.
//

import UIKit

class WeatherDailyCell: UICollectionViewCell {
    
    static let identifier = "WeatherDailyCell"
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var conditionIconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = 15
    }

    func configCell(hour: Hour) {
        let time = hour.time.components(separatedBy: " ")
        if time.count > 1 {
            timeLabel.text = time[1]
        }
        
        windSpeedLabel.text = String(hour.windKph) + " km/h"
        temperatureLabel.text = String(hour.tempC) + "°C"
    }
    
    func configCell(image: UIImage?) {
        conditionIconImage.image = image
    }
    
}
