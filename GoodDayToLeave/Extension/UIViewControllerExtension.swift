//
//  UIViewControllerExtension.swift
//  mPI
//
//  Created by Macintosh on 6/7/18.
//  Copyright © 2018 Macintosh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class func initWithDefaultNib() -> Self {
        let bundle = Bundle.main
        let fileManege = FileManager.default
        let nibName = String(describing: self)
        
        if let pathStoryboard = bundle.path(forResource: nibName, ofType: "storyboardc") {
            if fileManege.fileExists(atPath: pathStoryboard) {
                return initWithDefautlStoryboard()
            }
        }
        
        if let pathXib = bundle.path(forResource: nibName, ofType: "nib") {
            if fileManege.fileExists(atPath: pathXib) {
                return initWithNibTemplate()
            }
        }
        return initWithNibTemplate()
    }
    
    class func initWithNibTemplate<T>() -> T {
        var nibName = String(describing: self)
        if Constants.isIpad {
            if let pathXib = Bundle.main.path(forResource: "\(nibName)_\(Constants.iPad)", ofType: "nib") {
                if FileManager.default.fileExists(atPath: pathXib) {
                    nibName = "\(nibName)_\(Constants.iPad)"
                }
            }
        }
        let viewcontroller = self.init(nibName: nibName, bundle: Bundle.main)
        return viewcontroller as! T
    }
    
//    private class func initWithNibTemplate<T>() -> T {
//        let nibName = String(describing: self)
//        let viewcontroller = self.init(nibName: nibName, bundle: Bundle.main)
//        return viewcontroller as! T
//    }
    
    @objc class func initWithDefautlStoryboard() -> Self {
        let className = String(describing: self)
        return instantiateFromStoryboardHelper(storyboardName: className, storyboardId: className)
    }
    
    private class func instantiateFromStoryboardHelper<T>(storyboardName: String, storyboardId: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: storyboardId) as! T
        return controller
    }
    
    func showAlert(title: String?, message: String?, completeHanle : ((() -> Swift.Void)?)) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        
        let dismissAction = UIAlertAction(title: "Settings", style: UIAlertAction.Style.default) { (_) in
            if completeHanle != nil {
                completeHanle!()
            }
        }
        alertView.addAction(cancelAction)
        alertView.addAction(dismissAction)
        
        let viewController = UIApplication.shared.windows.first?.rootViewController
        DispatchQueue.main.async {
            viewController!.present(alertView, animated: true, completion: nil)
        }
    }
    
    func showAlertCancel(title: String?, message: String?) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertView.addAction(cancelAction)
        present(alertView, animated: true, completion: nil)
    }
    
    func doLinkPressed(linkUrl: String) {
        guard let url = URL(string: linkUrl) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func doEmailPrssed() {
        
    }
    
    func doCallPressed(phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            print("Device not support")
        }
    }
    
    func createFileTxt(jsonText: String) {
        if var url = try? FileManager.default.url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: false) {
            url = url.appendingPathComponent("ar").appendingPathExtension("txt")
            if FileManager.default.fileExists(atPath: url.path) {
                try! FileManager.default.removeItem(at: url)
            }
            if let data = jsonText.data(using: .utf8) {
                do {
                    try data.write(to: url)
                    print("---successful 😊")
                } catch {
                    print("unsuccessful")
                }
            }
        }
    }
    
    func writeToDocumentsFile(value: String) {
        let filename = "ar"
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let path = documentsPath.appendingPathComponent("\(filename).txt")
        do{
            try value.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
        }catch{
        }
    }
    
    func showAlertState(_ typeError: TableState,_ message: String) {
        let alertEmptyState = AlertEmptyStateViewController.init(message)
        alertEmptyState.typeError = typeError
        present(alertEmptyState, animated: true, completion: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
