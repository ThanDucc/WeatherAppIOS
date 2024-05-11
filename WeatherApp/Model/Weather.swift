//
//  Weather.swift
//  WeatherApp
//
//  Created by ThanDuc on 11/05/2024.
//

import Foundation

class Weather: Codable {
    let current: Current
    let forecast: Forecast

    init(current: Current, forecast: Forecast) {
        self.current = current
        self.forecast = forecast
    }
}

class Current: Codable {
    let tempC: Int
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
    }

    init(temC: Int, condition: Condition) {
        self.tempC = temC
        self.condition = condition
    }
}

class Condition: Codable {
    let text, icon: String
    let code: Int

    init(text: String, icon: String, code: Int) {
        self.text = text
        self.icon = icon
        self.code = code
    }
}

class Forecast: Codable {
    let forecastday: [Forecastday]

    init(forecastday: [Forecastday]) {
        self.forecastday = forecastday
    }
}

class Forecastday: Codable {
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case hour
    }

    init(hour: [Hour]) {
        self.hour = hour
    }
}

class Hour: Codable {
    let time: String
    let tempC: Double
    let condition: Condition
    let windKph: Double
    
    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
        case windKph = "wind_kph"
    }

    init(time: String, temC: Double, condition: Condition, windKph: Double) {
        self.time = time
        self.tempC = temC
        self.condition = condition
        self.windKph = windKph
    }
}

