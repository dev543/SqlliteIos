//
//  UserDefault+Extension.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 31/01/24.
//

import Foundation

extension UserDefaults {
    
    func setLoginFlag(isLoggedIn: Bool) {
        UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
    }

    func getLoginFlag() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    func setEmail(isEmail: String){
        UserDefaults.standard.set(isEmail, forKey: "isEmail")
        UserDefaults.standard.synchronize()
    }
    
    func getEmail() -> String {
        return UserDefaults.standard.string(forKey: "isEmail") ?? ""
    }
    
    func setPassword(isPassword: String){
        UserDefaults.standard.set(isPassword, forKey: "isPassword")
        UserDefaults.standard.synchronize()
    }
    
    func getPassword() -> String {
        return UserDefaults.standard.string(forKey: "isPassword") ?? ""
    }
    
    func setApi(isApi: Bool) {
        UserDefaults.standard.set(isApi, forKey: "isApi")
        UserDefaults.standard.synchronize()
    }

    func getApi() -> Bool {
        return UserDefaults.standard.bool(forKey: "isApi")
    }
    
    func setPostData(isJsonData: Bool) {
        UserDefaults.standard.set(isJsonData, forKey: "isJsonData")
        UserDefaults.standard.synchronize()
    }

    func getPostData() -> Bool {
        return UserDefaults.standard.bool(forKey: "isJsonData")
    }
}
