//
//  AboutUsAndTermsViewModel.swift
//  IDEA Hospital
//
//  Created by yasser on 12/25/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

//MARK:- SettingsViewModel Protocol
protocol AboutUsAndTermsViewModelProtocol: class {
    func getContent()
    func getScreenTitle()->String
}

class AboutUsAndTermsViewModel{
    //MARK:- Properties
    private weak var view: AboutUsAndTermsVCProtocol!
    private var screenType: ScreenType
    private var screenTitle: String!
    private var info: String!
    
    init(view: AboutUsAndTermsVCProtocol, screenType: ScreenType){
        self.view = view
        self.screenType = screenType
    }
    
    //MARK:- Private Methods
    private func getAboutUsContent(){
        view.showLoader()
        APIManager.aboutUsContent{ (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Loading Error", title: "OK")
            case .success(let result):
                self.info = result.data.aboutUs
                self.view.getContent(content: self.info)
                print(result)
            }
            self.view.hideLoader()
        }
    }
    
    private func getTermsAndConditionsContent(){
        view.showLoader()
        APIManager.termsAndConditionsContent{ (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Loading Error", title: "OK")
                
            case .success(let result):
                self.info = result.data.termsAndConditions
                self.view.getContent(content: self.info)
                print(result)
            }
            self.view.hideLoader()
        }
    }
}

//MARK:- AboutUsAndTermsVC Protocol Funcs
extension AboutUsAndTermsViewModel: AboutUsAndTermsViewModelProtocol{
    func getScreenTitle()->String{
        switch screenType{
        case .aboutUs:
            return ScreensTitle.aboutUs
        default:
            return ScreensTitle.termsAndConditions
        }
    }
    
    func getContent(){
        switch screenType{
        case .aboutUs:
            getAboutUsContent()
        default:
            getTermsAndConditionsContent()
        }
    }
}
