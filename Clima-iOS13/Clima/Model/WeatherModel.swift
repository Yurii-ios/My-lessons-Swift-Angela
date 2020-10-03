//
//  WeatherModel.swift
//  Clima
//
//  Created by Yurii Sameliuk on 04/11/2019.
//

import Foundation

struct WeatherModel {
    // sochraniaemue peremennue
    let conditionId: Int
    let cityName: String
    let temperature: Double
    //wu4esliaemaja peremennaja
    var conditionName: String {
        // id pogodu iz saita, k kotoromy priswojaem kartinky
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    // prinimaem temperatyry  iz saita i formatiryem
    var temeretyrestring: String {
        return String(format: "%.1f", temperature)
    }
}
