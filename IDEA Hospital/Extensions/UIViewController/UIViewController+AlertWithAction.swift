//
//  UIViewController+AlertWithAction.swift
//  IDEA Hospital
//
//  Created by yasser on 12/24/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

extension UIViewController {
    func openCustomAlert(type: AlertTypes, message: String, title: String, completion: (()->Void)? = nil){
        let alert = AlertViewController.create(type: type)
        
        alert.type = type
        alert.message = message
        alert.buttonTitle = title
        alert.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        alert.completion = completion
        alert.delegate = self as? AlertViewControllerDelegate
        self.present(alert, animated: true, completion: nil)
    }
    
    func openRegistrationPopUp(doctorId: Int, appointmentTimeStamp: String,completion: (()->Void)? = nil){
        let popup = SignUpAndLoginPopUpController.create(doctorId: doctorId, appointmentTimeStamp: appointmentTimeStamp)
        popup.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        popup.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.addChild(popup)
        popup.didMove(toParent: self)
        popup.view.frame = view.frame
        popup.signUpAndLoginPopUpView.layoutIfNeeded()
        popup.delegate = self as? SignUpAndLoginPopUpDelegate
        self.view.addSubview(popup.view)
    }
}
