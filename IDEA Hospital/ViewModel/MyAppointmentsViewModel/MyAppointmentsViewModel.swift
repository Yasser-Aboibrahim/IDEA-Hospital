//
//  MyAppointmentsViewModel.swift
//  IDEA Hospital
//
//  Created by yasser on 12/19/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation
import SDWebImage

//MARK:- MyAppointmentsViewModelprotocol
protocol MyAppointmentsViewModelProtocol: class{
    func deleteAppointmentSuccessfully(index: Int)
    func configureMyAppointmentsCell(cell: MyAppointmentsCellProtocol, index: Int)
    func cellCount()-> Int
    func getMapLocation(index: Int)
    func getAppointmentsDataWithPagination(pagination:Bool)
    func paginationStatus()-> Bool
    func setUpNavBar()
    func navigateFromWhere(comeFromSettings: Bool)
}

class MyAppointmentsViewModel{
    
    //MARK:- Properties
    private weak var view: MyAppointmentsVCProtocol!
    private var doctorAppointmentArr = [Doctor]()
    private var userAppointmentsItemsArr = [AppointmentsItems]()
    private var isPaginating = false
    private var pageForPagination = 1
    private var perPageForPagination = 10
     private var comeFromSeetings: Bool!
    
    init(view: MyAppointmentsVCProtocol){
        self.view = view
    }
}

//MARK:-Extension MyAppointmentsViewModelprotocol func
extension MyAppointmentsViewModel: MyAppointmentsViewModelProtocol{
    
    func setUpNavBar(){
        self.comeFromWhere()
    }
    
    func navigateFromWhere(comeFromSettings: Bool) {
        self.comeFromSeetings = comeFromSettings
    }
    
    func paginationStatus() -> Bool {
        return isPaginating
    }
    
    
    func getAppointmentsDataWithPagination(pagination: Bool){
        if UserDefaultsManager.shared().token == nil{
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Sign in", title: "OK")
            return
        }
        view.showLoader()
        if pagination{
            isPaginating = true
        }
        APIManager.getUserAppointmentsDataWithPagination(page: pageForPagination,perPage: perPageForPagination){ (response) in
            self.view.tableFooterViewWithPagination()
            switch response{
            case .failure(let error):
                print(error)
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Loading Error", title: "OK")
            case .success(let result):
                guard !result.data.items.isEmpty else{
                    self.isPaginating = false
                    self.view.hideLoader()
                    if self.pageForPagination == 1{
                        self.view.noAppointmentsData()
                    }
                    return
                }
                
                for itemData in result.data.items{
                   self.userAppointmentsItemsArr.append(itemData)
                }
                
                for item in self.userAppointmentsItemsArr{
                    self.doctorAppointmentArr.append(item.doctor)
                }
                
                self.pageForPagination = self.pageForPagination + 1
                
                if pagination{
                    self.isPaginating = false
                }
                self.view.reloadData()
                print(result)
            }
            self.view.hideLoader()
        }
    }
    
    func getMapLocation(index: Int){
        let lat = doctorAppointmentArr[index].lat
        let lng = doctorAppointmentArr[index].lng
        let locationName = doctorAppointmentArr[index].address
        LocationOnMap.openMap(lat: lat!, lng: lng!, theLocationName: locationName!)
    }
    
    func cellCount() -> Int {
        return getDoctorAppointmentData()
    }
    
    func deleteAppointmentSuccessfully(index: Int) {
        deleteAppointments(index: index)
    }
    
    func configureMyAppointmentsCell(cell: MyAppointmentsCellProtocol, index: Int) {
        downloadImage(for: index){ image in
            cell.cellConfigure(image: image ?? UIImage(), name: self.doctorAppointmentArr[index].name ?? "", bio: self.doctorAppointmentArr[index].bio ?? "", time: self.doctorAppointmentArr[index].waitingTime ?? 0, rating: self.doctorAppointmentArr[index].rating ?? 0, reviews: self.doctorAppointmentArr[index].reviewsCount ?? 0, date: self.userAppointmentsItemsArr[index].appointment)
        }
    }
}

//MARK:- Extension Private Funcs
extension MyAppointmentsViewModel{
    // MARK:- Private Methods
    private func downloadImage(for Index: Int, completion: @escaping (UIImage?) -> Void) {
        view?.showLoader()
        SDWebImageManager.shared.loadImage(with: URL(string: doctorAppointmentArr[Index].image!), options: .highPriority, progress: nil) {[weak self] (image, _, error, _, _, _) in
            if let error = error {
                print(error.localizedDescription)
            } else if let image = image {
                completion(image)
            }
            self?.view?.hideLoader()
        }
    }
    
    private func getDoctorAppointmentData()->Int{
        return self.doctorAppointmentArr.count
    }
    
    private func deleteAppointments(index: Int){
        view.showLoader()
        APIManager.deleteAppointment(id: userAppointmentsItemsArr[index].id){ (response) in
            switch response{
            case .failure(let error):
                print(error)
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Loading Error", title: "OK")
            case .success(let result):
                self.pageForPagination = 1
                self.doctorAppointmentArr = []
                self.userAppointmentsItemsArr = []
                
                self.getAppointmentsDataWithPagination(pagination: true)
                print(result)
            }
            self.view.hideLoader()
        }
    }
    
    private func comeFromWhere(){
        if comeFromSeetings{
            self.view?.setUPNavBarComeFromSettings(haveSettingBTN: false)
        }else{
            self.view?.setUPNavBarComeFromHome(haveSettingBTN: true)
            self.view?.setUpTabBar()
        }
    }
}
