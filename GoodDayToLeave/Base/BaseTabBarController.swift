//
//  BaseTabBarController.swift
//  HandShake
//
//  Created by hnc on 11/14/17.
//  Copyright © 2017 vietpd-iOS. All rights reserved.
//

import UIKit
import AVFoundation

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        self.delegate = self
        self.tabBar.isTranslucent = false
        self.tabBar.isOpaque = false
        self.tabBar.barTintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
