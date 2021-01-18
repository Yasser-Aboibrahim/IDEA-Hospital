//
//  LoginView.swift
//  IDEA Hospital
//
//  Created by Hossam on 12/24/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class LoginView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var loginButton: CommonButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    //MARK:- Public Methods
    func setup() {
        addBackground()
        setButton()
        setUpTextField()
    }
}

//MARK:- Extenion Private Methods
extension LoginView {
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
    
    private func setUpTextField(){
        emailTextField.addLineView(leftImage: UIImage(named: "EmailIcon")!, placeholder: "Your Email")
        passwordTextField.addLineView(leftImage: UIImage(named: "Password")!, placeholder: "Enter Password")
    }
    
    private func setButton() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 20)
        loginButton.setTitleColor(.white , for: .normal)
        forgetPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgetPasswordButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 15)
        forgetPasswordButton.setTitleColor(.white , for: .normal)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 20)
        signUpButton.setTitleColor(.white , for: .normal)
        signUpButton.backgroundColor = UIColor.init(red: 132.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 3
    }
}
