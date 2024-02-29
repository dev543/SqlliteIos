//
//  UserModel.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 17/01/24.
//

import Foundation

class UserModel {
    
    var id          : Int?
    var image       : String?
    var firstName   : String?
    var lastName    : String?
    var email       : String?
    var password    : String?
    var mobileNo    : String?
    var dob         : String?
    var country     : String?
    var state       : String?
    var city        : String?
    var about       : String?
    var gender      : Bool?
  
    init(id: Int?,image: String?,firstName: String?,lastName: String?,email: String? = nil, password: String? = nil,mobileNo: String?,dob: String?,country: String,state: String,city: String?,about: String?,gender: Bool?) {
        
        self.id         = id
        self.image      = image
        self.firstName  = firstName
        self.lastName   = lastName
        self.email      = email
        self.password   = password
        self.mobileNo   = mobileNo
        self.dob        = dob
        self.country    = country
        self.state      = state
        self.city       = city
        self.about      = about
        self.gender     = gender
        
    }
}

class HistoryModel {
    
    var id          : Int?
    var image       : String?
    var name        : String?
    var title       : String?
    var date        : String?
    let longitude   : Double?
    let latitude    : Double?
    
    init(id: Int?, image: String, name: String, title: String, date: String,latitude: Double, longitude: Double) {
        self.id         = id
        self.image      = image
        self.name       = name
        self.title      = title
        self.date       = date
        self.latitude   = latitude
        self.longitude  = longitude
    }
}

class PostModel {
    
    var id          : Int?
    var name        : String?
    var title       : String?
    var details     : String?
    var image       : String?
    var isSelcted   : String?
    
    init(id: Int?, name: String?, title: String?, details: String?, image: String?, isSelcted: String?) {
        
        self.id         = id
        self.name       = name
        self.title      = title
        self.details    = details
        self.image      = image
        self.isSelcted  = isSelcted
    }
}
