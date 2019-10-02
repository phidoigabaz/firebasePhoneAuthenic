//
//  SearchTextField.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/16.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

protocol SearchTextFieldDelegate: NSObjectProtocol {
    func textFieldShouldReturn(_ textField: UITextField)
}

class SearchTextField: UIView {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    weak var delegate: SearchTextFieldDelegate?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        textField.delegate = self
    }
    
    class func instanceFromNib() -> SearchTextField {
        let view = UINib(nibName: "SearchTextField", bundle: nil).instantiate(withOwner: self, options: nil).first as? SearchTextField
        return view!
    }
}

extension SearchTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let delegate = self.delegate {
            delegate.textFieldShouldReturn(textField)
        }
        return true
    }
}
