//
//  EditProfileVC.swift
//  IDEA Hospital
//
//  Created by yasser on 1/8/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import UIKit

//MARK:- EditProfileVCProocol
protocol EditProfileVCProtocol: class{
    func showCusromAlert(type: AlertTypes, message: String, title: String)
    func showCusromAlertSuccessfullyProfileUpdated(type: AlertTypes, message: String, title: String)
    func setUserData(userData: UserDataEditProfile)
}

class EditProfileVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var editProfileView: EditProfileView!
    
    //MARK:- Properties
    private var viewModel: EditProfileViewModelProtocol!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBackground()
        setNavigation()
        viewModel.getUserDataResponse()
    }
    
    //MARK:- Public Methods
    class func create() -> EditProfileVC {
        let editProfileVC: EditProfileVC = UIViewController.create(storyboardName: Storyboards.editProfile, identifier: ViewControllers.editProfileVC)
        editProfileVC.viewModel = EditProfileViewModel(view: editProfileVC)
        return editProfileVC
    }
    

    //MARK:- Actions
    @IBAction func saveBtnTapped(_ sender: CommonButton) {
        viewModel.editUserProfile(name: editProfileView.nameTextField.text!, email: editProfileView.emailTextField.text!, mobile: editProfileView.mobileTextField.text!, password: editProfileView.newPasswordTextField.text!, oldPassword: editProfileView.oldPasswordTextField.text!, confirmationPassword: editProfileView.confirmPasswordTextField.text! )
    }
    
    @IBAction func cancelBtnTapped(_ sender: CommonButton) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK:- Extension Private Methods
extension EditProfileVC{
    private func setNavigation(){
        setupNavController(title: "Edit Profile", settingColor: false)
        setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: false)
    }
    
    private func goToHomeVC() {
        let homeVC = HomeVC.create()
        navigationController?.pushViewController(homeVC, animated: true)
    }
}

//MARK:- Extension EditProfileVCProtocol Funcs
extension EditProfileVC: EditProfileVCProtocol{
    func setUserData(userData: UserDataEditProfile){
        editProfileView.setup(userData: userData)
    }
    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
    
    func showCusromAlertSuccessfullyProfileUpdated(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title){
            self.dismiss(animated: true){
                self.goToHomeVC()
            }
        }
    }
}
