//
//  SignUpandLoginPopupView.swift
//  IDEA Hospital
//
//  Created by Hossam Yasser on 1/8/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class SignUpandLoginPopupView: UIView {

    //MARK:- Outlets
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var enterNameTextField: CustomTextField!
    @IBOutlet weak var enterEmailTextField: CustomTextField!
    @IBOutlet weak var enterNumberTextField: CustomTextField!
    @IBOutlet weak var enterPasswordTextField: CustomTextField!
    @IBOutlet weak var signUpBtn: CommonBigButton!
    @IBOutlet weak var firstCheckBtn: UIButton!
    @IBOutlet weak var secondCheckBtn: UIButton!
    @IBOutlet weak var enterCodeTextField: CustomSmallTextField!
    @IBOutlet weak var enterothePersonNameTextField: CustomSmallTextField!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginEnterEmailTextField: CustomTextField!
    @IBOutlet weak var loginEnterPasswordTextField: CustomTextField!
    @IBOutlet weak var loginFirstCheckBtn: UIButton!
    @IBOutlet weak var loginSecondcheckBtn: UIButton!
    @IBOutlet weak var loginEnterVoucherTextField: CustomSmallTextField!
    @IBOutlet weak var loginEnterOtherPersonNameTextField: CustomSmallTextField!
    @IBOutlet weak var loginAndBookBtn: CommonBigButton!
    @IBOutlet weak var termsAndConditionBtn: UIButton!
    
    //MARK:-  Setup
    func setup() {
        registerBtnTapped()
        loginBtnTapped()
        signUpView.backgroundColor = .clear
        signUpView.isHidden = true
        setupTextField()
        setUpSignupBtn()
        setUpLoginBtn()
        loginView.backgroundColor = .clear
        signUpView.isHidden = false
        loginView.isHidden = true
        enterCodeTextField.isUserInteractionEnabled = false
        enterothePersonNameTextField.isUserInteractionEnabled = false
        loginEnterVoucherTextField.isUserInteractionEnabled = false
        loginEnterOtherPersonNameTextField.isUserInteractionEnabled = false
        registerBtn.backgroundColor = .white
        registerBtn.setTitleColor(UIColor(red: 0.0, green: 24.0/255.0, blue: 103.0/255.0, alpha: 1.0), for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
    }
}

//MARK:- Private Methods
extension SignUpandLoginPopupView{
    
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
}

//MARK:- Public Methods
extension SignUpandLoginPopupView {
    
    func  registerBtnTapped(){
        registerBtn.backgroundColor = .clear
        registerBtn.titleLabel?.text = "Register"
        registerBtn.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 20)
        registerBtn.roundCorners(with: [.layerMinXMinYCorner], radius: 20)
    }
    
    func registerBtnPressed() {
        signUpView.isHidden = false
        loginView.isHidden = true
        registerBtn.backgroundColor = .white
        loginBtn.backgroundColor = .clear
        registerBtn.setTitleColor(UIColor(red: 0.0, green: 24.0/255.0, blue: 103.0/255.0, alpha: 1.0), for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
    }
    
    func loginBtnTapped(){
        loginBtn.backgroundColor = .clear
        loginBtn.titleLabel?.text = "Login"
        loginBtn.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 20)
        loginBtn.roundCorners(with: [.layerMaxXMinYCorner], radius: 20)
      
    }
    
    func loginBtnPressed() {
        signUpView.isHidden = true
        loginView.isHidden = false
        loginBtn.backgroundColor = .white
        registerBtn.backgroundColor = .clear
        loginBtn.setTitleColor(UIColor(red: 0.0, green: 24.0/255.0, blue: 103.0/255.0, alpha: 1.0), for: .normal)
        registerBtn.setTitleColor(.white, for: .normal)
    }
    
    func setupTextField() {
        enterNameTextField.addLineView(leftImage: UIImage(named: "UserIcon")!, placeholder: "Your Name")
        enterEmailTextField.addLineView(leftImage: UIImage(named: "EmailIcon")!, placeholder: "Your Email")
        enterNumberTextField.addLineView(leftImage: UIImage(named: "Image")!, placeholder: "Mobile Number")
        enterPasswordTextField.addLineView(leftImage: UIImage(named: "Password")!, placeholder: "Choose Password")
        
        enterCodeTextField.addunderline(placeholder: "Enter Code")
        enterothePersonNameTextField.addunderline(placeholder: "Enter Name")
        
        loginEnterEmailTextField.addLineView(leftImage: UIImage(named: "EmailIcon")!, placeholder: "Your Email")
        loginEnterPasswordTextField.addLineView(leftImage: UIImage(named: "Password")!, placeholder: "Enter Password")
        
        loginEnterVoucherTextField.addunderline(placeholder: "Enter Code")
        loginEnterOtherPersonNameTextField.addunderline(placeholder: "Enter Name")
    }
    
    func setUpSignupBtn() {
        signUpBtn.setTitle("Sign Up & Book", for: .normal)
        signUpBtn.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 17)
        signUpBtn.titleLabel?.textColor = .white
        signUpBtn.titleLabel?.tintColor = .white
        
    }
    
    func setUpLoginBtn() {
        loginAndBookBtn.setTitle("Login & Book" , for: .normal)
        loginAndBookBtn.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 17)
        loginAndBookBtn.titleLabel?.textColor = .white
        loginAndBookBtn.titleLabel?.tintColor = .white
        
    }
    
    func loginDefault(){
        loginEnterEmailTextField.text! = ""
        loginEnterOtherPersonNameTextField.text! = ""
        loginEnterPasswordTextField.text! = ""
        loginEnterVoucherTextField.text! = ""
        loginSecondcheckBtn.setImage(UIImage(named:"Rectangle 1798"), for: .normal)
        loginSecondcheckBtn.tintColor = .clear
        loginFirstCheckBtn.setImage(UIImage(named:"Rectangle 1798"), for: .normal)
        loginFirstCheckBtn.tintColor = .clear
    }
    
    func registerDefault(){
        enterNameTextField.text! = ""
        enterEmailTextField.text! = ""
        enterNumberTextField.text! = ""
        enterPasswordTextField.text! = ""
        enterCodeTextField.text! = ""
        enterothePersonNameTextField.text! = ""
        secondCheckBtn.setImage(UIImage(named:"Rectangle 1798"), for: .normal)
        firstCheckBtn.setImage(UIImage(named:"Rectangle 1798"), for: .normal)
        secondCheckBtn.tintColor = .clear
        secondCheckBtn.tintColor = .clear
    }
    
    func firstCheckBtnTapped()-> Bool{
        if firstCheckBtn.tintColor == .white {
            firstCheckBtn.setImage(UIImage(named: "checkimage"), for: .normal)
            enterCodeTextField.isUserInteractionEnabled = true
            firstCheckBtn.tintColor = UIColor.clear
            return true
        }else{
            firstCheckBtn.setImage(UIImage(named: "Rectangle 1798"), for: .normal)
            enterCodeTextField.isUserInteractionEnabled = false
            enterCodeTextField.text = ""
            firstCheckBtn.tintColor = UIColor.white
            return false
        }
    }
    
    func secondCheckBtnTapped()-> Bool{
        if secondCheckBtn.tintColor == UIColor.white {
            secondCheckBtn.setImage(UIImage(named: "checkimage"), for: .normal)
            enterothePersonNameTextField.isUserInteractionEnabled = true
            secondCheckBtn.tintColor = UIColor.clear
            return true
        }else{
            secondCheckBtn.setImage(UIImage(named: "Rectangle 1798"), for: .normal)
            enterothePersonNameTextField.isUserInteractionEnabled = false
            enterothePersonNameTextField.text = ""
            secondCheckBtn.tintColor = UIColor.white
            return false
        }
    }
    
    func loginFirstCheckBtnTapped()-> Bool{
        if loginFirstCheckBtn.tintColor == UIColor.white {
            loginFirstCheckBtn.setImage(UIImage(named: "checkimage"), for: .normal)
            loginEnterVoucherTextField.isUserInteractionEnabled = true
            loginFirstCheckBtn.tintColor = UIColor.clear
            return true
        }else{
            loginFirstCheckBtn.setImage(UIImage(named: "Rectangle 1798"), for: .normal)
            loginEnterVoucherTextField.isUserInteractionEnabled = false
            loginEnterVoucherTextField.text = ""
            loginFirstCheckBtn.tintColor = UIColor.white
            return false
        }
    }
    
    func loginSecondcheckBtnTapped()-> Bool{
        if loginSecondcheckBtn.tintColor == UIColor.white {
            loginSecondcheckBtn.setImage(UIImage(named: "checkimage"), for: .normal)
            loginEnterOtherPersonNameTextField.isUserInteractionEnabled = true
            loginSecondcheckBtn.tintColor = UIColor.clear
            return true
        }else{
            loginSecondcheckBtn.setImage(UIImage(named: "Rectangle 1798"), for: .normal)
            loginEnterOtherPersonNameTextField.isUserInteractionEnabled = false
            loginEnterOtherPersonNameTextField.text = ""
            loginSecondcheckBtn.tintColor = UIColor.white
            return false
        }
    }
}
