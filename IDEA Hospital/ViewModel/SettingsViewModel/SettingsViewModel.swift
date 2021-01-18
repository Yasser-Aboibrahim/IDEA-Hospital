//
//  SettingsViewModel.swift
//  IDEA Hospital
//
//  Created by yasser on 12/25/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

//MARK:- SettingsViewModel Protocol
protocol SettingsViewModelProtocol: class {
    func settingsArrCount()-> Int
    func cellCongiure(cell:SettingsCellProtocol ,index: Int)
    func selectedCell(index: Int)
    func logOut()
}

class SettingsViewModel{
    
    //MARK:- Properties
    private weak var view: SettingsVCProtocol!
    
    private let settingsUserArr: [[String]] = [[SettingsPhotoIcons.editProfile,Settings.editProfile],[SettingsPhotoIcons.favorite,Settings.favorite],[SettingsPhotoIcons.bookedAppointments,Settings.bookedAppointments],[SettingsPhotoIcons.aboutUs,Settings.aboutUs],[SettingsPhotoIcons.contactUs,Settings.contactUs],[SettingsPhotoIcons.share,Settings.share],[SettingsPhotoIcons.termsAndConditions,Settings.termsAndConditions],[SettingsPhotoIcons.logout,Settings.logout]]
    
    private let settingsGuestsArr: [[String]] = [[SettingsPhotoIcons.Login,Settings.Login],[SettingsPhotoIcons.aboutUs,Settings.aboutUs],[SettingsPhotoIcons.contactUs,Settings.contactUs],[SettingsPhotoIcons.share,Settings.share],[SettingsPhotoIcons.termsAndConditions,Settings.termsAndConditions]]
    
    init(view: SettingsVCProtocol){
        self.view = view
    }
}

//MARK:- Private Methods
extension SettingsViewModel{
    private func logOutPM() {
        view.showLoader()
        APIManager.logout{ (response) in
            switch response {
            case .failure (let error):
                print(error.localizedDescription)
                print(error)
            case .success(let result):
                print("succes logout")
                print(result)
                UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.token)
                self.view.goToHomeVC()
            }
        }
        self.view.hideLoader()
    }
}

//MARK:- SettingsViewModel Protocol Func
extension SettingsViewModel: SettingsViewModelProtocol{
    
    func logOut(){
        logOutPM()
    }
    
    func settingsArrCount() -> Int {
        if UserDefaultsManager.shared().token != nil{
            return self.settingsUserArr.count
        }
        return self.settingsGuestsArr.count
    }
    
    func cellCongiure(cell:SettingsCellProtocol ,index: Int){
        if UserDefaultsManager.shared().token != nil{
                cell.configure(image: settingsUserArr[index][0], title: settingsUserArr[index][1])
        }else{
                cell.configure(image: settingsGuestsArr[index][0], title: settingsGuestsArr[index][1])
        }
    }
    
    func selectedCell(index: Int){
    if UserDefaultsManager.shared().token != nil{
            switch settingsUserArr[index][1]{
            case Settings.editProfile:
                print("go to edit profile")
                view.goToEditProfile()
            case Settings.favorite:
                print("go to favorite")
                view.goToFavoriteVC()
            case Settings.bookedAppointments:
                print("go to appointments")
                view.goToMyAppointmentsVC()
            case Settings.aboutUs:
                print("go to about us")
                view.goToAboutUsAndTerms(screenType: .aboutUs)
            case Settings.contactUs:
                print("go to contact us")
                view.goToContactUsVC(screenType: .contactUs)
            case Settings.share:
                print("share")
                view.shareSettings()
            case Settings.termsAndConditions:
                print("Terms & Conditions")
                view.goToAboutUsAndTerms(screenType: .termsAndConditions)
            case Settings.logout:
                self.view.showCustomAlertSuccessfullyLoggedOut(type: .defaultAlertTwoButtons(title: "Sure To Logout ?!"), message: "", title: "")
                print("Logouts")
            default:
                return
            }
        }else{
            switch settingsGuestsArr[index][1]{
            case Settings.Login:
                print("Login")
                view.goToLoginVC()
            case Settings.aboutUs:
                print("go to about us")
                view.goToAboutUsAndTerms(screenType: .aboutUs)
            case Settings.contactUs:
                print("go to contact us")
                view.goToContactUsVC(screenType: .contactUs)
            case Settings.share:
                view.shareSettings()
                print("share")
            case Settings.termsAndConditions:
                view.goToAboutUsAndTerms(screenType: .termsAndConditions)
                print("Terms & Conditions")
            default:
                return
            }
        }
    }
}
