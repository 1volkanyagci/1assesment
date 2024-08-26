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
