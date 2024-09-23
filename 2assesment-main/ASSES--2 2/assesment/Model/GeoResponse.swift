//
//  Response.swift
//  assesment
//
//  Created by Volkan Yagci on 8/24/24.
//

import Foundation
//done
struct GeoResponse: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}

enum WeatherIcon: String {
    case clearDay = "10d"
    
    var iconURL: String {
        return "https://openweathermap.org/img/wn/\(self.rawValue)@2x.png"
    }
}
