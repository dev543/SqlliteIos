//
//  LocationModel.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 12/01/24.
//

import Foundation

class LocationModel {
    var country: String
    var states: [StateModel]

    init(country: String, states: [StateModel]) {
        self.country = country
        self.states  = states
    }
}

class StateModel {
    var name: String
    var cities: [String]

    init(name: String, cities: [String]) {
        self.name = name
        self.cities = cities
    }
}

class CityModel {
    var name: String

    init(name: String) {
        self.name = name
    }
}

class VenueModel {
    
    let name        : String?
    let category    : String?
    let longitude   : Double?
    let latitude    : Double?

    init(name: String, category: String, latitude: Double, longitude: Double) {
        self.name       = name
        self.category   = category
        self.latitude   = latitude
        self.longitude  = longitude
    }
}
