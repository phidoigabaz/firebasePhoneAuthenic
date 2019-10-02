//
//  BaseViewController.swift
//  WherePet
//
//  Created by Tuan Nguyen on 2019/09/03.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import EmptyStateKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        
    }
}

extension BaseViewController: EmptyStateDelegate {
    func emptyState(emptyState: EmptyState, didPressButton button: UIButton) {
        emptyState.hide()
    }
}
