//
//  ResetPasswordVC.swift
//  IDEA Hospital
//
//  Created by Hossam on 12/24/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit


protocol ResetPasswordVCProtocol: class {
    func showLoader()
    func hideLoader()
    func showCusromAlert(type: AlertTypes, message: String, title: String)
    func showCustomAlertSuccessfullyPasswordReset(type: AlertTypes, message: String, title: String)
}

class ResetPasswordVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var ResetPasswordView: ResetPasswordView!
    
    // MARK:- Properties
    private var viewModel: ResetPasswordViewModelProtocol!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
     setStatusBar()
     ResetPasswordView.setup()
     setNavigation()

    }
    
    //MARK:- Public Methods
    class func create() -> ResetPasswordVC {
        let resetPasswordVC: ResetPasswordVC = UIViewController.create(storyboardName: Storyboards.resetPassword, identifier: ViewControllers.resetPasswordVC)
    resetPasswordVC.viewModel = ResetPasswordViewModel(view: resetPasswordVC )
        return resetPasswordVC
    }

    //MARK:- Actions
    @IBAction func setNewPasswordButton(_ sender: CommonButton) {
        viewModel.resetForgottenPassword(email: ResetPasswordView.emailTextField.text!)
    }
    
    //MARK:- private Methods
    private func goToSignInVC(){
        navigationController?.popViewController(animated: true)
    }
    
    private func setNavigation(){
        setupNavController(title: "Reset Password", settingColor: false)
        setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: false)
    }
}

//MARK:- Extension ResetPasswordVCProtocol Funcs
extension ResetPasswordVC : ResetPasswordVCProtocol {
    
    func showLoader() {
        view.showLoading()
    }
    
    func hideLoader() {
        view.hideLoading()
    }
    
    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
    
    func showCustomAlertSuccessfullyPasswordReset(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title){
            self.dismiss(animated: true){
                self.goToSignInVC()
            }
        }
    }
}
