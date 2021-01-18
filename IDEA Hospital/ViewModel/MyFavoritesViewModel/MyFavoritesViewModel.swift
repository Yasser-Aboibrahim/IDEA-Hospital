//
//  MyFavoritesViewModel.swift
//  IDEA Hospital
//
//  Created by yasser on 12/18/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation
import SDWebImage

//MARK:- MyFavoritesViewModel Protocol
protocol MyFavoritesViewModelProtocol: class {
    func configureMyFavoritesCell(cell: MyFavoritesCellProtocol, index: Int)
    func cellCount()-> Int
    func addAndRemoveFavorites(index: Int)
    func getFavoritesDataPagination(pagination: Bool)
    func paginationStatus()-> Bool
    func goToViewProfile(index: Int)
    func setUpNavBar()
    func navigateFromWhere(comeFromSettings: Bool)
}

class MyFavoritesViewModel{
    
    //MARK:- Properties
    private weak var view: MyFavoritesVCProtocol!
    private var favoritesData = [Doctor]()
    private var isPaginating = false
    private var pageForPagination = 1
    private var perPageForPagination = 10
    private var comeFromSeetings: Bool!

    
    init(view: MyFavoritesVCProtocol){
        self.view = view
    }
}

// Mark:- Extension HomeViewModel Protocol funcs
extension MyFavoritesViewModel: MyFavoritesViewModelProtocol{
    
    func setUpNavBar(){
        self.comeFromWhere()
    }
    func navigateFromWhere(comeFromSettings: Bool) {
        self.comeFromSeetings = comeFromSettings
    }
    
    func goToViewProfile(index: Int) {
        let id = favoritesData[index].id
        view.goToDoctorProfileVC(doctorId: id!)
    }
    
    func getFavoritesDataPagination(pagination: Bool) {
        getFavoritesDataWithPagination(pagination: pagination)
    }
    
    func addAndRemoveFavorites(index: Int) {
        andAndRemoveFavoritesData(index: index)
    }
    
    func cellCount()-> Int {
        return favoritesData.count
    }
    
    func configureMyFavoritesCell(cell: MyFavoritesCellProtocol, index: Int) {
        let address = "\(self.favoritesData[index].region ?? ""): \(self.favoritesData[index].address ?? "")"
        downloadImage(for: index){ image in
            cell.configure(drImage: image ?? UIImage(), name: self.favoritesData[index].name ?? "", Specialist: self.favoritesData[index].specialty ?? "", address: address, Specialist2: self.favoritesData[index].secondBio ?? "", time: self.favoritesData[index].waitingTime ?? 0, fees: self.favoritesData[index].fees ?? 0, rating: self.favoritesData[index].rating ?? 0, reviews: self.favoritesData[index].reviewsCount ?? 0)
        }
    }
    
    func paginationStatus() -> Bool {
        return isPaginating
    }
    
}

//MARK:- Extension Private Methods
extension MyFavoritesViewModel{
    //MARK:-  Private Methods
    private func andAndRemoveFavoritesData(index: Int){
        view.showLoader()
        APIManager.addAndRemoveFavorite(id: favoritesData[index].id!){ (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Loading Error", title: "OK")
            case .success(let result):
                self.favoritesData = []
                self.pageForPagination = 1
                self.getFavoritesDataWithPagination(pagination: true)
                self.view.reloadData()
                print(result)
            }
            self.view.hideLoader()
        }
    }
    
    private func downloadImage(for Index: Int, completion: @escaping (UIImage?) -> Void) {
        view?.showLoader()
        SDWebImageManager.shared.loadImage(with: URL(string: favoritesData[Index].image!), options: .highPriority, progress: nil) {[weak self] (image, _, error, _, _, _) in
            if let error = error {
                print(error.localizedDescription)
            } else if let image = image {
                completion(image)
            }
            self?.view?.hideLoader()
        }
    }
    
    private func getFavoritesDataWithPagination(pagination: Bool) {
        if UserDefaultsManager.shared().token == nil{
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Sign in", title: "OK")
            return
        }
        view.showLoader()
        if pagination{
            isPaginating = true
        }
        APIManager.getFavoritesDataWithPagination(page: pageForPagination, perPage: perPageForPagination){ (response) in
            self.view.tableFooterViewWithPagination()
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Loading Error", title: "OK")

            case .success(let result):
                guard !result.data.items.isEmpty else{
                    self.isPaginating = false
                    self.view.hideLoader()
                    if self.pageForPagination == 1{
                        self.view.noFavoriteData()
                    }
                    return
                }
                for itemData in result.data.items{
                    self.favoritesData.append(itemData)
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
    
    private func comeFromWhere(){
        if comeFromSeetings{
            self.view?.setUPNavBarComeFromSettings(haveSettingBTN: false)
        }else{
            self.view?.setUPNavBarComeFromHome(haveSettingBTN: true)
            self.view?.setUpTabBar()
        }
    }
}
