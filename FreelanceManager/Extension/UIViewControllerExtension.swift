//
//  UIViewControllerExtension.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/21/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import AVFoundation
import CDAlertView

extension UIViewController {
    
    func loginSituation() {
//        if Authorization.shared.isLoggedIn {
//            //
//        } else {
//            //
//        }
    }
    
}

extension UIViewController {
    
    func backBarButtonAttribute(color: UIColor, name: String) {
        let backButton = UIBarButtonItem(title: name, style: UIBarButtonItem.Style.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.persianFont(size: 15)], for: .normal)
        backButton.tintColor = color
        navigationItem.backBarButtonItem = backButton
    }
    
}

// MENU ANIMATION
extension UIViewController {
    
    func showAnimate() {
        self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 1.4) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform.identity
        }
    }
    
    func removeAnimate(boxView: UIView? = nil) {
        if let boxView = boxView {
            self.sideHideAnimate(view: boxView)
        }
        UIView.animate(withDuration: 1.4, animations: {
            self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.view.alpha = 0.0
        }) { (finished) in
            if finished {
                self.view.removeFromSuperview()
            }
        }
    }
    
    func sideShowAnimate(view: UIView) {
        view.transform = CGAffineTransform.init(translationX: UIScreen.main.bounds.width, y: 0)
        UIView.animate(withDuration: 1.4) {
            view.transform = CGAffineTransform.identity
        }
    }
    
    func sideHideAnimate(view: UIView) {
        UIView.animate(withDuration: 1.4, animations: {
            view.transform = CGAffineTransform.init(translationX: UIScreen.main.bounds.width, y: 0)
        }) { (finished) in
            if finished {
                //
            }
        }
    }
    
}



extension UIViewController {
    
    func startIndicatorAnimate() {
        let vc = IndicatorViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func stopIndicatorAnimate() {
        NotificationCenter.default.post(name: DISMISS_INDICATOR_VC_NOTIFY, object: nil)
    }
    
}

extension UIViewController {
    
    func presentWarningAlert(message: String) {
//        let alert = CDAlertView(title: "توجه", message: message, type: CDAlertViewType.notification)
//        alert.titleFont = UIFont(name: MORVARID_FONT, size: 15)!
//        alert.messageFont = UIFont(name: MORVARID_FONT, size: 13)!
//        let cancel = CDAlertViewAction(title: "باشه", font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white, handler: nil)
//        alert.add(action: cancel)
//        alert.show()
    }
    
    func phoneNumberCondition(phoneNumber number: String) -> Bool {
        guard !number.isEmpty else {
            let message = "شماره همراه خالی میباشد !"
            presentWarningAlert(message: message)
            return false
        }
        let startIndex = number.startIndex
        let zero = number[startIndex]
        guard zero == "0" else {
            let message = "شماره همراه خود را با صفر وارد کنید !"
            presentWarningAlert(message: message)
            return false
        }
        guard number.count == 11 else {
            let message = "شماره همراه میبایست یازده رقمی باشد !"
            presentWarningAlert(message: message)
            return false
        }
        
        return true
    }
    
}

extension UIViewController {
    //
}

