//
//  WeatherData.swift
//  Clima
//
//  Created by Yurii Sameliuk on 04/11/2019.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Main:Decodable {
    
    let temp: Double
}
struct Weather: Decodable {
    let id: Int
}

