//
//  AuxiliarFunctions.swift
//  Giveth
//
//  Created by David Niño on 21/06/22.
//

import Foundation

class AuxiliarFuncitons {
    
    static func loadLocalUserEmail() -> String {
        if let user = UserDefaults.standard.string(forKey: "loggedInEntity"){
            return user
        }
        return ""
    }
    
    static func saveLocalUserEmail(email: String) {
        UserDefaults.standard.set(email, forKey: "loggedInEntity")
    }
    
    static func saveIsCharityProperty(_ isCharity: Bool){
        UserDefaults.standard.set(isCharity, forKey: "isCharityProperty")
    }
    
    static func loadIsCharityProperty() -> Bool {
        return UserDefaults.standard.bool(forKey: "isCharityProperty")
    }
}
