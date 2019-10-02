//
//  HomeViewController.swift
//  WherePet
//
//  Created by Tuan Nguyen on 2019/08/30.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import Floaty

class HomeViewController: BaseViewController {

    @IBOutlet weak var floaty: Floaty!
    var notifyBarButton: MJBadgeBarButton!
    var weatherService  = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func setupView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.menuBarButtonItem(target: self, btnAction: #selector(showleftMenu))
        notifyBarButton = UIBarButtonItem.notifyBarButtonItem(target: self, btnAction: #selector(showNotification))
        navigationItem.setRightBarButton(notifyBarButton, animated: false)
        layoutFAB()
        floaty.addDragging()
        weatherService.getWeatherLocation(35, 139) { (model, err) in
            print(model)
        }
    }
    
    func layoutFAB() {
        floaty.addItem("get location currrent", icon: UIImage(named: "navigation")) { item in
            let searchVC = SearchViewController.initWithDefaultNib()
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
        self.view.addSubview(floaty)
    }
    
    //MARK: ACTION
    @objc func showleftMenu() {
        mm_drawerController.toggle(.left, animated: true, completion: nil)
    }
    
    @objc func showNotification() {
        
    }
}
