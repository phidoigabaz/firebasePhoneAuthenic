//
//  BaseNavigationController.swift
//  HandShake
//
//  Created by hnc on 11/14/17.
//  Copyright © 2017 vietpd-iOS. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.delegate = self
    }
    
    func setUp() {
        self.navigationBar.isHidden = false
        self.navigationBar.isOpaque = false
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.black
        self.navigationBar.barTintColor = AppColor.navigationColor()
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .default
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    class func initWithDefaultStyle(rootViewController: UIViewController!) -> BaseNavigationController {
        let nav = BaseNavigationController(rootViewController: rootViewController)
        nav.setUp()
        return nav
    }
    
}

extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool) {
        if let currentVC = self.topViewController {
            let itemBack = UIBarButtonItem(title: "", style: .done, target: currentVC, action: nil)
            currentVC.navigationItem.backBarButtonItem = itemBack
        }
    }
}

extension UINavigationController {

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if visibleViewController?.supportedInterfaceOrientations == .landscape {
            return .landscape
        }
        return .portrait
    }

    override open var shouldAutorotate: Bool {
        return true
    }

    static func navigate(to vc: UIViewController) {
        if let topVc = UINavigationController.topController() {
            topVc.navigationController?.pushViewController(vc, animated: true)
        }
    }

    static func topController() -> UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        if let navigation = topController as? UINavigationController {
            topController = navigation.visibleViewController
        }
        return topController
    }
}
