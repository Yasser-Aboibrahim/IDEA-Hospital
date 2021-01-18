//
//  AboutUsAndTermsVC.swift
//  IDEA Hospital
//
//  Created by yasser on 12/25/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

//MARK:- AboutUsAndTermsVC Protocol
protocol AboutUsAndTermsVCProtocol: class{
    func showLoader()
    func hideLoader()
    func getContent(content: String)
    func showCusromAlert(type: AlertTypes, message: String, title: String)
}

class AboutUsAndTermsVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var aboutUsAndTermsView: AboutUsAndTermsView!
    
    //MARK:- Properties
    private var viewModel: AboutUsAndTermsViewModel!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        viewModel.getContent()
        setNavigation()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- public Methods
    class func create(screenType: ScreenType) -> AboutUsAndTermsVC {
        let aboutUsAndTermsVC: AboutUsAndTermsVC = UIViewController.create(storyboardName: Storyboards.aboutUsAndTerms, identifier: ViewControllers.aboutUsAndTermsVC)
        aboutUsAndTermsVC.viewModel = AboutUsAndTermsViewModel(view: aboutUsAndTermsVC, screenType: screenType)
        return aboutUsAndTermsVC
    }
    
    //MARK:- Private Methods
    private func setNavigation(){
        setupNavController(title: viewModel.getScreenTitle(), settingColor: false)
        setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: false)
    }
    
}

//MARK:- AboutUsAndTermsVC Protocol Funcs
extension AboutUsAndTermsVC: AboutUsAndTermsVCProtocol{
    func showLoader() {
        self.view.showLoading()
    }
    
    func hideLoader() {
        self.view.hideLoading()
    }
    
    func getContent(content: String){
        aboutUsAndTermsView.setup(content: content)
    }
    
    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
}
