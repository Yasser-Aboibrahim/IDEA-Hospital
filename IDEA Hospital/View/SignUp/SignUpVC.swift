//
//  SignUpVC.swift
//  IDEA Hospital
//
//  Created by Hossam on 12/25/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

//MARK:- SignUpVC Protocol
protocol  SignUpVCProtocol: class{
    func showLoader()
    func hideLoader()
    func showCusromAlert(type: AlertTypes, message: String, title: String)
    func showCustomAlertSuccessfullySignedUp(type: AlertTypes, message: String, title: String)
}

class SignUpVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var SignUpView: SignUpView!
    
    // MARK:- Properties
    private var viewModel: SignUpViewModel!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    SignUpView.setup()
    setStatusBar()
    setNavigation()
    }
    
    //Mark:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.signUp, identifier: ViewControllers.signUpVC)
        signUpVC.viewModel = SignUpViewModel(view: signUpVC )
        return signUpVC
    }
    
    //MARK:- Actions
    @IBAction func signUpButtonTapped(_ sender: CommonButton) {
        viewModel.signUpUser( name: SignUpView.nameTextField.text!, email: SignUpView.emailTextField.text!, mobile: SignUpView.mobileTextField.text!, password: SignUpView.passwordTextField.text!, confirmationPassword: SignUpView.confirmPasswordTextField.text!)
    }
    @IBAction func termsAndConditionsBtnTapped(_ sender: UIButton) {
        goToAboutUsAndTermsVC()
    }
}

//MARK:- Extension Private Methods
extension SignUpVC{
    private func goToAboutUsAndTermsVC() {
        let aboutUsAndTermsVC = AboutUsAndTermsVC.create(screenType: .termsAndConditions)
        navigationController?.pushViewController(aboutUsAndTermsVC, animated: true)
    }
    
    private func goToHomeVC(){
        let homeVC = HomeVC.create()
        navigationController?.pushViewController(homeVC, animated: true)
    }
    
    private func setNavigation(){
        setupNavController(title: "Sign Up", settingColor: false)
        setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: false)
    }
}

//MARK:- Extension SignUpVCProtocol func
extension SignUpVC : SignUpVCProtocol{
    func showLoader() {
        view.showLoading()
    }
    
    func hideLoader() {
        view.hideLoading()
    }
    
    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
    
    func showCustomAlertSuccessfullySignedUp(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title){
            self.dismiss(animated: true){
                self.goToHomeVC()
            }
        }
    }
}
