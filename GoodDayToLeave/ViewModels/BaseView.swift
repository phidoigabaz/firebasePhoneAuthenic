//
//  BaseView.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/16.
//  Copyright © 2019 dattt. All rights reserved.
//

import Foundation

protocol BaseView: class {
    func show(_ loading: Bool)
    
    func showError(_ error: String)
}

extension BaseView {
    
    func show(_ loading: Bool) {
        //
    }
    
    func showError(_ error: String) {
        //
    }
}
