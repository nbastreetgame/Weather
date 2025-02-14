//
//  DadataModel.swift
//  WeatherStore
//
//  Created by Андрей Попов on 22.01.2025.
//

import Foundation

struct DadataResponse: Decodable {
    let suggestions: [CitySuggestion]
}

struct CitySuggestion: Decodable {
    let data: CityData
}

struct CityData: Decodable {
    let city: String?
    let latitude: String?
    let longitude: String?
    let region: String?

    private enum CodingKeys: String, CodingKey {
        case city
        case latitude = "geo_lat"
        case longitude = "geo_lon"
        case region = "region_with_type"
    }
}
