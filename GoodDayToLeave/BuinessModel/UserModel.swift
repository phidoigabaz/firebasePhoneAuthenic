//
//  UserModel.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/24.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    var displayName: String
    var uid: String
    var phone: String
    var email: String
    var photoURL: String
    var providerId: String
    
    init(_ displayName: String,_ uid: String,_ phone: String,_ email: String,_ photoURL: String,_ providerId: String) {
        self.displayName = displayName
        self.uid = uid
        self.phone = phone
        self.email = email
        self.photoURL = photoURL
        self.providerId = providerId
    }
}
