//
//  LoginVC.swift
//  IDEA Hospital
//
//  Created by Hossam on 12/24/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

protocol LoginVCProtocol: class {
    func showLoader()
    func hideLoader()
    func goToHomeVC()
    func showCusromAlert(type: AlertTypes, message: String, title: String)
    func showCustomAlertSuccessfullyLoggedIn(type: AlertTypes, message: String, title: String)
}


class LoginVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var LoginView: LoginView!
    
    // MARK:- Properties
    private var viewModel: LoginViewModel!

    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginView.setup()
        setStatusBar()
        setNavigation()
    }
    

    //MARK:- Public Methods
    class func create() -> LoginVC {
        let loginVC: LoginVC = UIViewController.create(storyboardName: Storyboards.login, identifier: ViewControllers.loginVC)
        loginVC.viewModel = LoginViewModel(view: loginVC  )
        return loginVC
    }
    
    //MARK:- Private Methods
    private func setNavigation(){
        setupNavController(title: "LOGIN", settingColor: false)
        setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: false)
    }
    
    private func goToSignUpVC(){
        let signUpVC = SignUpVC.create()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    private func goToResetPasswordVc(){
        let resetPasswordVC = ResetPasswordVC.create()
        navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
    
    //MARK:- Actions
    @IBAction func forgetPasswordTapped(_ sender: UIButton) {
    goToResetPasswordVc()
    }
    
    
    @IBAction func loginButtonTapped(_ sender: CommonButton) {
        viewModel.login(email: LoginView.emailTextField.text!, password: LoginView.passwordTextField.text!)
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        goToSignUpVC()
    }
}

//MARK:- Extension LoginVCProtocol Funs
extension LoginVC : LoginVCProtocol {
    func showLoader() {
        view.showLoading()
    }
    
    func hideLoader() {
        view.hideLoading()
    }
    
    func goToHomeVC() {
        let homeVC = HomeVC.create()
        navigationController?.pushViewController(homeVC, animated: true)
    }
    
    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
    
    func showCustomAlertSuccessfullyLoggedIn(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title){
            self.dismiss(animated: true){
                self.goToHomeVC()
            }
        }
    }
}
