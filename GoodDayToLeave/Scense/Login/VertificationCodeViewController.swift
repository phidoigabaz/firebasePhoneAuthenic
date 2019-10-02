//
//  VertificationCodeViewController.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/19.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import FirebaseAuth

class VertificationCodeViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var activeFieldView: SGCodeTextField!
    @IBOutlet weak var autoTextField: UITextField!
    @IBOutlet weak var testLabel: UILabel!
    
    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    var vertificationID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //activeFieldView.delegate = self
    }
    
    override func setupView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.backBarButtonItem1(target: self, btnAction: #selector(backAction))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        scrollView.contentInsetAdjustmentBehavior = .never
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //MARK: METHODS
    func firebaseVertifyCode(_ verificationCode: String) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: vertificationID, verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                return
            }
            
            if let user = user {
                DataManager.save(object: user.user.uid, forKey: Constants.kUID_USER)
            }
            Constants.appDelegate.showDrawMenu()
        }
    }
    
    //MARK: ACTION
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSendAction(_ sender: Any) {
        if let text = activeFieldView.text {

            self.firebaseVertifyCode(text)
        }
        self.view.endEditing(true )
    }
}


//MARK: keyboard Handing
extension VertificationCodeViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardHeight == nil {
            return
        }
        UIView.animate(withDuration: 0.3) {
            self.constraintContentHeight.constant -= self.keyboardHeight
            self.scrollView.contentOffset = self.lastOffset
        }
        
        keyboardHeight = nil
    }
}
