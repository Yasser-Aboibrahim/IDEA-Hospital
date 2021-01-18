//
//  SignUpView.swift
//  IDEA Hospital
//
//  Created by Hossam on 12/25/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    
    // MARK:- Outlets
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var mobileTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField!
    @IBOutlet weak var signUpButton: CommonButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var termsAndConditionsLabel: UIButton!
    
    //MARK:- Public Methods
    func setup() {
        addBackground()
        setUpLabel()
        setUpButton()
        setUpTextField()
    }
}

//MARK:- Extenion Private Methods
extension SignUpView {
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
    
    private func setUpLabel() {
        infoLabel.numberOfLines = 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        infoLabel.text = "By clicking sign up, you agree to our"
        infoLabel.adjustsFontSizeToFitWidth = true
        infoLabel.textAlignment = NSTextAlignment.left;
        infoLabel.textColor = UIColor.white
        infoLabel.font = UIFont(name: "PTSans-Regular" ,
                                 size: 12)
        infoLabel.lineBreakMode = .byWordWrapping
        
    }
    
    private func setUpButton() {
        termsAndConditionsLabel.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 12)
        termsAndConditionsLabel.setTitle("Terms & Conditions", for: .normal)
        termsAndConditionsLabel.setTitleColor(.white , for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 20)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.white , for: .normal)
        
    }
    
    private func setUpTextField() {
        nameTextField.addLineView(leftImage: UIImage(named: "UserIcon")!, placeholder: "Your Name")
        emailTextField.addLineView(leftImage: UIImage(named: "EmailIcon")!, placeholder: "Your Email")
        mobileTextField.addLineView(leftImage: UIImage(named: "Image")!, placeholder: "Mobile Number")
        passwordTextField.addLineView(leftImage: UIImage(named: "Password")!, placeholder: "Choose Password")
        confirmPasswordTextField.addLineView(leftImage: UIImage(named: "Password")!, placeholder: "Confirm Password")
    }
}
