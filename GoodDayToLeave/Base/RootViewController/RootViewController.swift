//
//  RootViewController.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/11.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import MMDrawerController

class RootViewController: MMDrawerController {

    class func initMenuStyle() -> UIViewController {
        let leftVC = MenuViewController.initWithDefaultNib()
        let homeVC = HomeViewController.initWithDefaultNib()
        let centerNav = BaseNavigationController(rootViewController: homeVC)
        let mm_vc = MMDrawerController(center: centerNav, leftDrawerViewController: leftVC)
        mm_vc?.modalTransitionStyle = .coverVertical
        mm_vc?.showsShadow = false
        return mm_vc!
    }
}
