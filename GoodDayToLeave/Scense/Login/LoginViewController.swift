//
//  LoginViewController.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/19.
//  Copyright © 2019 dattt. All rights reserved.
//
import Foundation
import UIKit
import FirebaseAuth
import DropDown

class LoginViewController: BaseViewController {

    @IBOutlet weak var visualeffectView: UIVisualEffectView!
    @IBOutlet weak var visualeffectView1: UIVisualEffectView!
    @IBOutlet weak var inputPhoneView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var backButton: CustomButton!
    @IBOutlet weak var sendButton: CustomButton!
    @IBOutlet weak var superImageView: UIImageView!
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    @IBOutlet weak var codePhoneLabel: UILabel!
    @IBOutlet weak var codePhoneButton: UIButton!
    
    let codePhoneDropDown = DropDown()
    var viewModel = LoginViewModel()
    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    var models: [CodePhoneModel] = []
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.codePhoneDropDown
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: LifeCycle
    override func setupView() {
        scrollView.contentInsetAdjustmentBehavior = .never
        visualeffectView.layer.cornerRadius = 10
        visualeffectView.layer.masksToBounds = true
        visualeffectView1.layer.cornerRadius = 10
        visualeffectView1.layer.masksToBounds = true
        inputPhoneView.layer.cornerRadius = 10
        backButton.setTinColorImage()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        superImageView.isUserInteractionEnabled = true
        superImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //MARK: METHODS
    func getData() {
        setupDropDown()
    }
    
    //dropdown
    func setupDropDown() {
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .bottom }
        codePhoneDropDown.backgroundColor = .white
        codePhoneDropDown.textColor = AppColor.textColorDropDown()
        codePhoneDropDown.anchorView = codePhoneButton
        codePhoneDropDown.textFont = UIFont.systemFont(ofSize: 13.0)
        codePhoneDropDown.cornerRadius = 10
        codePhoneDropDown.bottomOffset = CGPoint(x: 0, y: 40)
        models = viewModel.getcodePhoneCountries()
        for i in models {
            codePhoneDropDown.dataSource.append(i.code)
        }
        codePhoneDropDown.selectionAction = { [weak self] (index, item) in
            self?.codePhoneLabel.text = item
        }
    }
    
    func phoneAuthentication(_ phoneNumber: String) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (vertificationId, error) in
            if error != nil,let err = error {
                self.showAlertState(.noLogin, err.localizedDescription)
                return
            }
            
            if let vertificationId = vertificationId {
                let vertifyCodeVC = VertificationCodeViewController.initWithDefaultNib()
                vertifyCodeVC.vertificationID = vertificationId
                self.navigationController?.pushViewController(vertifyCodeVC, animated: true)
            }
        }
    }
    
    func validationLogin() {
        phoneTextField.resignFirstResponder()
        if let numberPhone = phoneTextField.text,!numberPhone.isEmpty,let codeCall = codePhoneLabel.text {
            phoneAuthentication("\(codeCall)\(numberPhone.formatPhoneNumberFirst(numberPhone))")
        } else {
            if let desc = TableState.noLogin.description {
                self.showAlertState(.noLogin, desc)
            }
        }
    }
    
    func showAnimation(_ visualview: UIVisualEffectView, _ visualView1: UIVisualEffectView) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            visualview.isHidden = true
            visualView1.isHidden = false
        }, completion: nil)
    }
    
    //MARK: ACTIONS
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func onLoginAction(_ sender: Any) {
        showAnimation(visualeffectView, visualeffectView1)
    }
    
    @IBAction func onBackAction(_ sender: Any) {
        showAnimation(visualeffectView1, visualeffectView)
    }
    
    @IBAction func onSendAction(_ sender: Any) {
        validationLogin()
    }
    
    @IBAction func onDropDownAction(_ sender: Any) {
        codePhoneDropDown.show()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        lastOffset = self.scrollView.contentOffset
        return true
    }
}

//MARK: keyboard Handing
extension LoginViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardHeight != nil {
            return
        }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            // so increase contentView's height by keyboard height
            UIView.animate(withDuration: 0.3, animations: {
                self.constraintContentHeight.constant += self.keyboardHeight
            })
            
            // move if keyboard hide input field
            guard let activeField = activeField else {
                return
            }
            let distanceToBottom = self.scrollView.frame.size.height - (activeField.frame.origin.y) - (activeField.frame.size.height)
            let collapseSpace = keyboardHeight - distanceToBottom
            
            if collapseSpace < 0 {
                // no collapse
                return
            }
            
            // set new offset for scroll view
            UIView.animate(withDuration: 0.3, animations: {
                // scroll to the position above keyboard 10 points
                self.scrollView.contentOffset = CGPoint(x: self.lastOffset.x, y: collapseSpace + 10)
            })
        }
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
