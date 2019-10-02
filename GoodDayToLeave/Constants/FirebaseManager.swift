//
//  FirebaseManager.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/10/01.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import FirebaseAuth

class FirebaseManager: NSObject {
    static let sharedInstance: FirebaseManager = {
        let instance = FirebaseManager()
        return instance
    }()
    
    func doLogout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            DataManager.clearLoginSession()
            Constants.appDelegate.showSplashViewController()
            print("done!!!")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
