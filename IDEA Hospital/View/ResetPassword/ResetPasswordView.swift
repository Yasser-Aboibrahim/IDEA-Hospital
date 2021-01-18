//
//  ResetPasswordView.swift
//  IDEA Hospital
//
//  Created by Hossam on 12/24/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class ResetPasswordView: UIView {
    
    // MARK:- Outlets
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var setNewPasswordButton: CommonButton!
    
    //MARK:- Public Methods
    func setup() {
        addBackground()
        setUpTextField(textField: emailTextField, placeHolder: "Your Email")
        setButton()
    }
}

//MARK:- Extenion Private Methods
extension ResetPasswordView {
    private func addBackground(imageName: String = "BackGroundpicture", contentMode: UIView.ContentMode = .scaleToFill) {
        // setup the UIImageView
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = contentMode
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)
        // adding NSLayoutConstraints
        let leadingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
    private func setUpTextField(textField: CustomTextField , placeHolder: String){
        textField.font = UIFont(name: "PTSans-Bold", size: 15)
        textField.textColor = UIColor.white
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "PTSans-Bold", size: 15)!])
        textField.setLeftPaddingPoints(50)
        textField.addLineView(leftImage: UIImage(named: "Password")!, placeholder: "Enter Password")
    }
    
    private func setButton() {
    setNewPasswordButton.setTitle("Set New Password", for: .normal)
        setNewPasswordButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 20)
        setNewPasswordButton.setTitleColor(.white , for: .normal)
        
    }
}
