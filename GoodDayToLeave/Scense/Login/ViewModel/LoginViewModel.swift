//
//  LoginViewModel.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/23.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {
    
    var codePhoneModels: [CodePhoneModel] = []
   
    func getcodePhoneCountries() -> [CodePhoneModel] {
        return  DataManager.shared.getcodeCallingList()
    }
}
