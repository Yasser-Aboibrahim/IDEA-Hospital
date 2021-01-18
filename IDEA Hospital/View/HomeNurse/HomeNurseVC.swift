//
//  HomeNurseVC.swift
//  IDEA Hospital
//
//  Created by Hossam on 12/18/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

//MARK:- ScreenType Enum
enum ScreenType{
    case homeNurse
    case contactUs
    case aboutUs
    case termsAndConditions
}

//MARK:- HomeNurseVCProtocol
protocol HomeNurseVCProtocol: class{
    func goToHomeScreen()
    func showLoader()
    func hideLoader()
    func showCusromAlert(type: AlertTypes, message: String, title: String)
    func showCustomAlertSuccessfullySent(type: AlertTypes, message: String, title: String)

    
}

class HomeNurseVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var HomeNurseView: HomeNurseView!
    
    // MARK:- Properties
    var viewModel: HomeNurseViewModel!

    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeNurseView.setup(screenType: viewModel.getScreenType())
        setupBackground()
        HomeNurseView.enterDetailsTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homeNurseAndContactUs(screenType: viewModel.getScreenType())
    }

    class func create(screenType: ScreenType) -> HomeNurseVC {
        let homeNurseVC: HomeNurseVC = UIViewController.create(storyboardName: Storyboards.homeNurse, identifier: ViewControllers.homeNurseVC)
        homeNurseVC.viewModel = HomeNurseViewModel(view: homeNurseVC, screenType: screenType)
        return homeNurseVC
    }

    //MARK:- Actions
    @IBAction func sendRequestButton(_ sender: UIButton) {
        viewModel.sendRequest(name: HomeNurseView.nameTextField.text!, email: HomeNurseView.EmailTextField.text!, mobile: HomeNurseView.mobileNumberTextField!.text! , message: HomeNurseView.enterDetailsTextView.text!)
    }
    
    //MARK:- Private Methods
    private func setNavigation(){
        setupNavController(title: viewModel.getScreenTitle(), settingColor: false)
        setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: true)
    }
    
}

//MARK:- Extension UITextView Delegate

extension  HomeNurseVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter Details" {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter Details"
        }
    }
}

//MARK:- Extension HomeNurceVC Protocol funcs
extension HomeNurseVC: HomeNurseVCProtocol{
    func goToHomeScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func showLoader() {
        view.showLoading()
    }
    
    func hideLoader() {
        view.hideLoading()
    }
    
    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
    
    func showCustomAlertSuccessfullySent(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title){
            self.dismiss(animated: true){
                self.goToHomeScreen()
            }
        }
    }
}
