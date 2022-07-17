//
//  User.swift
//  Giveth
//
//  Created by David Niño on 05/06/22.
//

import Foundation

class LoginUser {
    private var email: String?
    private var password: String?

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func getEmail() -> String {
        guard let email = email else {
            return "Empty email"
        }
        return email
    }
    
    func getPwd() -> String {
        guard let password = password else {
            return "Empty password"
        }
        return password
    }
}

class RegisterUser {
    private var name: String?
    private var contact: String?
    private var address: String?
    private var city: String?
    private var country: String?
    private var zipCode: String?
    private var description: String?
    private var email: String?
    private var password: String?
    private var isCharity: Bool?
    
    init() {}
    
    init(name: String, contact: String, address: String, city: String, country: String, zipCode: String, description: String, email: String, password: String, isCharity: Bool) {
        self.name = name
        self.contact = contact
        self.address = address
        self.city = city
        self.country = country
        self.zipCode = zipCode
        self.description = description
        self.email = email
        self.password = password
        self.isCharity = isCharity
    }
    
    func getName() -> String {
        guard let name = name else {
            return "Empty name"
        }
        return name
    }
    
    func getContact() -> String {
        guard let contact = contact else {
            return "Empty contact"
        }
        return contact
    }
    
    func getAddress() -> String {
        guard let address = address else {
            return "Empty address"
        }
        return address
    }
    
    func getCity() -> String {
        guard let city = city else {
            return "Empty city"
        }
        return city
    }
    
    func getCountry() -> String {
        guard let country = country else {
            return "Empty country"
        }
        return country
    }
    
    func getZipCode() -> String {
        guard let zipCode = zipCode else {
            return "Empty zipCode"
        }
        return zipCode
    }
    
    func getDescription() -> String {
        guard let description = description else {
            return "Empty description"
        }
        return description
    }
    
    func getEmail() -> String {
        guard let email = email else {
            return "Empty email"
        }
        return email
    }
    
    func getPwd() -> String {
        guard let password = password else {
            return "No password"
        }
        return password
    }
    
    func getUserCharity() -> Bool {
        guard let isCharity = isCharity else {
            return false
        }
        return isCharity
    }
}

class CharityUser {
    
    var name: String?
    var email: String?
    var password: String?
    var address: String?
    var city: String?
    var country: String?
    var zipCode: String?
    var contact: String?
    var description: String?
    var isCharity: Bool?
    var imageUrl: String?
    
    init() {}
    
    init(name: String, contact: String, address: String, city: String, country: String, zipCode: String, description: String, email: String, password: String, imageUrl: String) {
        self.name = name
        self.contact = contact
        self.address = address
        self.city = city
        self.country = country
        self.zipCode = zipCode
        self.description = description
        self.email = email
        self.password = password
        self.isCharity = true
        self.imageUrl = imageUrl
    }

    
    
    func getName() -> String {
        guard let name = self.name, name != "" else {
            return "Unknown name"
        }
        return name
    }
}

class RestaurantUser {
    var name: String?
    var email: String?
    var password: String?
    var address: String?
    var city: String?
    var country: String?
    var zipCode: String?
    var contact: String?
    var description: String?
    var isCharity: Bool?
    var imageUrl: String?
    
    init () {}
    
    init(name: String, contact: String, address: String, city: String, country: String, zipCode: String, description: String, email: String, password: String, imageUrl: String) {
        self.name = name
        self.contact = contact
        self.address = address
        self.city = city
        self.country = country
        self.zipCode = zipCode
        self.description = description
        self.email = email
        self.password = password
        self.isCharity = false
        self.imageUrl = imageUrl
    }
    
    func getName() -> String {
        guard let name = self.name, name != "" else {
            return "Unknown name"
        }
        return name
    }
    
}

class UploadData {
    var name: String?
    var contact: String?
    var address: String?
    var description: String?
    var image1: String?
    var image2: String?
    var email: String?
    
    init() {}
    init(name: String, contact: String, description: String, address: String, image1: String, image2: String, email: String){
        self.name = name
        self.contact = contact
        self.description = description
        self.address = address
        self.image1 = image1
        self.image2 = image2
        self.email = email
    }
    
    func getName() -> String {
        guard let name = name else {
            return "Empty name"
        }
        return name
    }
    
    func getContact() -> String {
        guard let contact = contact else {
            return "Empty contact"
        }
        return contact
    }
    
    func getAddress() -> String {
        guard let address = address else {
            return "Empty address"
        }
        return address
    }
    
    func getDescription() -> String {
        guard let description = description else {
            return "Empty description"
        }
        return description
    }
    
    func getImage1() -> String {
        guard let image1 = image1 else {
            return "Empty Image1"
        }
        return image1
    }
    
    func getImage2() -> String {
        guard let image2 = image2 else {
            return "Empty Image2"
        }
        return image2
    }
    
}
