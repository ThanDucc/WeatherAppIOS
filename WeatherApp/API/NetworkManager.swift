//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by ThanDuc on 11/05/2024.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(completion: @escaping(Weather?) -> Void) {
        guard let url = URL(string: Constants.url) else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            if let data = data {
                let weather: Weather? = try? JSONDecoder().decode(Weather.self, from: data)
                completion(weather)
            } else {
                print("Cannot fetch data")
            }
        })
        
        task.resume()
    }
    
    func loadImage(_ url: URL, completion: @escaping(UIImage) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data){
                completion(image)
            }
        }.resume()
        
    }
    
}
