//
//  HomeScreenViewModel.swift
//  WeatherApp
//
//  Created by ThanDuc on 11/05/2024.
//

import Foundation
import UIKit

class HomeScreenViewModel {
    
    var weather: Weather?
    
    func getWeatherInfor(completion: @escaping() -> Void) {
        NetworkManager.shared.fetchData { [weak self] weatherInfor in
            guard let self = self else { return }
            
            if let weatherInfor = weatherInfor {
                self.weather = weatherInfor
                completion()
            }
        }
    }
    
    func loadImage(string: String, completion: @escaping(UIImage?) -> Void) {
        guard let url = URL(string: "https:" + string) else {
            completion(nil)
            return
        }
        
        NetworkManager.shared.loadImage(url) { image in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
