//
//  SignUpAndLoginPopUpController.swift
//  IDEA Hospital
//
//  Created by yasser on 1/12/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import UIKit

protocol SignUpAndLoginPopUpDelegate: class{
    func getDoctorAppointments()
}

protocol SignUpAndLoginPopUpProtocol: class{
    func showLoader()
    func hideLoader()
    func showCusromAlert(type: AlertTypes, message: String, title: String)
    func showCustomAlertSuccessfullyRequest(type: AlertTypes, message: String, title: String)
    
}

class SignUpAndLoginPopUpController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet var signUpAndLoginPopUpView: SignUpandLoginPopupView!
    weak var delegate: SignUpAndLoginPopUpDelegate?
    
    // MARK:- Properties
    private var viewmodel: SignUpAndLoginPopUpViewModelProtocol!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpAndLoginPopUpView.setup()
        viewmodel.setDefaultData()
        signUpAndLoginPopUpView.registerDefault()
        signUpAndLoginPopUpView.loginDefault()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK:- Public Methods
    class func create(doctorId: Int, appointmentTimeStamp: String) -> SignUpAndLoginPopUpController {
        let signUpAndLoginPopUpController = SignUpAndLoginPopUpController()
        signUpAndLoginPopUpController.viewmodel = SignUpAndLoginPopUpViewModel(view: signUpAndLoginPopUpController,doctorId: doctorId, appointmentTimeStamp: appointmentTimeStamp)
        return signUpAndLoginPopUpController
    }
    
    //MARK:- Actions
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        signUpAndLoginPopUpView.registerBtnPressed()
        signUpAndLoginPopUpView.loginDefault()
        viewmodel.setDefaultData()
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        signUpAndLoginPopUpView.loginBtnPressed()
        viewmodel.setDefaultData()
        signUpAndLoginPopUpView.registerDefault()
    }
    
    @IBAction func firstCheckBtn(_ sender: UIButton) {
        viewmodel.getVoucherState(voucherEntered: signUpAndLoginPopUpView.firstCheckBtnTapped())
    }
    
    @IBAction func secondCheckBtn(_ sender: UIButton) {
        viewmodel.getNameState(nameEntered: signUpAndLoginPopUpView.secondCheckBtnTapped())
    }
    
    @IBAction func loginFirstCheckBtn(_ sender: UIButton) {
        viewmodel.getVoucherState(voucherEntered: signUpAndLoginPopUpView.loginFirstCheckBtnTapped())
    }
    
    @IBAction func loginSecondCheckBtn(_ sender: UIButton) {
        viewmodel.getNameState(nameEntered: signUpAndLoginPopUpView.loginSecondcheckBtnTapped())
    }
    
    @IBAction func signUpAndBookBtnTapped(_ sender: CommonBigButton) {
        viewmodel.signUpUser(name: signUpAndLoginPopUpView.enterNameTextField.text!, email: signUpAndLoginPopUpView.enterEmailTextField.text!, mobile: signUpAndLoginPopUpView.enterNumberTextField.text!, password: signUpAndLoginPopUpView.enterPasswordTextField.text!, voucher: signUpAndLoginPopUpView.enterCodeTextField.text!, patientName: signUpAndLoginPopUpView.enterothePersonNameTextField.text!, bookForAnother: signUpAndLoginPopUpView.secondCheckBtn.isSelected)
    }
    
    @IBAction func loginAndBookBtnTapped(_ sender: CommonBigButton) {
        viewmodel.login(email: signUpAndLoginPopUpView.loginEnterEmailTextField.text!, password: signUpAndLoginPopUpView.loginEnterPasswordTextField.text!, voucher: signUpAndLoginPopUpView.loginEnterVoucherTextField.text!, patientName: signUpAndLoginPopUpView.loginEnterOtherPersonNameTextField.text!, bookForAnother: signUpAndLoginPopUpView.loginSecondcheckBtn.isSelected)
        
    }
    
    @IBAction func termsAndConditionsBtnTapped(_ sender: UIButton) {
        goToAboutUsAndTermsVC()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        view.removeFromSuperview()
        removeFromParent()
    }
    
}

//MARK:- Extension Private Method
extension SignUpAndLoginPopUpController{
    private func goToAboutUsAndTermsVC() {
        
        let aboutUsAndTermsVC = AboutUsAndTermsVC.create(screenType: .termsAndConditions)
        self.navigationController?.pushViewController(aboutUsAndTermsVC, animated: true)
    }
}

//MARK:- Extension SignUpAndLoginPopUpController Protocol funcs
extension SignUpAndLoginPopUpController: SignUpAndLoginPopUpProtocol{
    func showLoader() {
        view.showLoading()
    }
    
    func hideLoader() {
        view.hideLoading()
    }
    
    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
    
    func showCustomAlertSuccessfullyRequest(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title){
            self.dismiss(animated: true){
                self.view.removeFromSuperview()
                self.removeFromParent()
                self.delegate?.getDoctorAppointments()
            }
        }
    }
    
}

