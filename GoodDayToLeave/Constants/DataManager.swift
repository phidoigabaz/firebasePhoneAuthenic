
//
//  DataManager.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/23.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import SwiftyJSON

class DataManager: NSObject {
    static let shared = DataManager()
    
    private override init() {
    }
    
    class func objectForKey(_ key: String) -> Any? {
        let userDefault = UserDefaults.standard
        return userDefault.value(forKey: key)
    }
    
    class func boolForKey(_ key: String) -> Bool {
        let userDefault = UserDefaults.standard
        return userDefault.bool(forKey: key)
    }
    
    class func integerForKey(_ key: String) -> Int {
        let userDefault = UserDefaults.standard
        return userDefault.integer(forKey: key)
    }
    
    class func removeObject(forKey key: String) {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: key)
        userDefault.synchronize()
    }
    
    class func save(object: Any, forKey key: String) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(object, forKey: key)
        userDefault.synchronize()
    }
    
    class func save(boolValue: Bool, forKey key: String) {
        let userDefault = UserDefaults.standard
        userDefault.set(boolValue, forKey: key)
        userDefault.synchronize()
    }
    
    class func save(integerValue: Int, forKey key: String) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(integerValue, forKey: key)
        userDefault.synchronize()
    }
    
    class func save(floatValue: Float, forKey key: String) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(floatValue, forKey: key)
        userDefault.synchronize()
    }
    
    class func floatForKey(_ key: String) -> Float {
        let userDefault = UserDefaults.standard
        return userDefault.float(forKey: key)
    }
    
    class func stringForKey(_ key: String) -> String? {
        let userDefault = UserDefaults.standard
        return userDefault.string(forKey: key)
    }
    
    class func clearLoginSession() {
        DataManager.removeObject(forKey: Constants.kUID_USER)
    }
    
    //parse: json filepath
    func getcodeCallingList() -> [CodePhoneModel] {
        var codePhoneModels:[CodePhoneModel] = []
        if let filepath = Bundle.main.path(forResource: "codePhone", ofType: "json"),
            let data = FileManager.default.contents(atPath: filepath) {
            do {
                let json = try JSON(data: data)
                for subJson in json.arrayValue {
                    let dto = CodePhoneDTO(subJson)
                    let model = CodePhoneModel(dto)
                    codePhoneModels.append(model)
                }
            } catch (let error) {
                print(error.localizedDescription)
                return []
            }
        }
        
        return codePhoneModels
    }
    
    //login
}
