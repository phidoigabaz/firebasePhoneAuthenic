//
//  SplashDetailViewController.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/12.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

class SplashDetailViewController: UIViewController {

    @IBOutlet weak var splashImageView: UIImageView!
    var splashSlide: SplashSlide
    
    init(splashSlide: SplashSlide) {
        self.splashSlide = splashSlide
        super.init(nibName: "SplashDetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashImageView.image = splashSlide.image
    }
}
