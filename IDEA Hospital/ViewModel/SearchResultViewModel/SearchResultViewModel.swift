//
//  SearchResultViewModel.swift
//  IDEA Hospital
//
//  Created by yasser on 12/24/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation
import SDWebImage

protocol SearchResultViewModelProtocol: class {
    func doctorCellCount()-> Int
    func tableViewCellConfiguration(cell: TableViewCellProtocol, index: Int)
    func addFavoritesuccessfully(index: Int)
    func doctorFilterPicker() -> [String]
    func selectedItems(row: Int)
    func paginationStatus()-> Bool
    func getSearchResultDataWithFiletsWithPaginationPro(pagination: Bool)
    func bookWithDoctorId(index: Int)
}

class SearchResultViewModel{
    //MARK:- Properties
    private weak var view: SearchResultVCProtocol!
    private var doctorArr = [Doctor]()
    private var sortArr = ["fees", "rating"]
    private var pageForPagination = 1
    private var perPageForPagination = 15
    private var isPaginating = false
    private var sortType: String = "fees"
    private var categoryId: Int?
    private var specialityID: Int?
    private var cityID: Int?
    private var regionID: Int?
    private var companyID: Int?
    private var doctorName: String?
    
    init(view: SearchResultVCProtocol,categoryId: Int, specialtyId:Int?, cityId:Int?, regionId:Int?, companyId: Int?, doctorName: String?){
        self.view = view
        self.categoryId = categoryId
        self.specialityID =  specialtyId
        self.cityID = cityId
        self.regionID = regionId
        self.companyID = companyId
        self.doctorName = doctorName
    }
}

//MARK:- Extension Private Methods
extension SearchResultViewModel{
    
    private func downloadImage(for Index: Int, completion: @escaping (UIImage?) -> Void) {
        view?.showLoader()
        SDWebImageManager.shared.loadImage(with: URL(string: doctorArr[Index].image!), options: .highPriority, progress: nil) {[weak self] (image, _, error, _, _, _) in
            if let error = error {
                print(error)
            } else if let image = image {
                completion(image)
            }
            self?.view?.hideLoader()
        }
    }
    
    private func addFavoriteDoctor(index: Int){
        if UserDefaultsManager.shared().token != nil {
        APIManager.addAndRemoveFavorite(id: doctorArr[index].id!) { (response) in
            switch response {
            case .failure(let error):
                if error.localizedDescription == "The data couldn’t be read because it isn’t in the correct format." {
                }else{
                    print(error.localizedDescription)
                }
            case .success(let result ):
                print(result)
                print("Done")
                
            }
          }
        }else{
            view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please LogIn First", title: "Ok")
        }
    }
    
    private func doctorArrCellCount()-> Int{
        return doctorArr.count
    }
    
    private func getSearchResultDataWithFiltersWithPagination(pagination: Bool) {
        view.showLoader()
        let body = categoryDataBodyRequest(page: self.pageForPagination, perPage: self.perPageForPagination, mainCategoryId: self.categoryId, specialtyId: self.specialityID, cityId: self.cityID, regionId: self.regionID, companyId: self.companyID, orderBy: self.sortType, name: self.doctorName)
        if pagination{
            isPaginating = true
        }
        
        APIManager.getDoctorDataFilterdWithFiltersWithPagination(body: body){ (response) in
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
                        self.view.noDoctorData()
                    }
                    return
                }
                for itemData in result.data.items{
                    self.doctorArr.append(itemData)
                }
                
                self.pageForPagination = self.pageForPagination + 1
                
                if pagination{
                    self.isPaginating = false
                }
                
                self.view.reloadData()
                print(result.data)
            }
            self.view.hideLoader()
        }
    }
}

// Mark:- Extension HomeViewModel Protocol funcs
extension SearchResultViewModel: SearchResultViewModelProtocol{
    func getSearchResultDataWithFiletsWithPaginationPro(pagination: Bool) {
        getSearchResultDataWithFiltersWithPagination(pagination: pagination)
    }
    
    func bookWithDoctorId(index: Int) {
        let id = doctorArr[index].id
        view.goToDoctorProfileVC(doctorId: id!)
        print("\(String(describing: id))")
    }
    
    func paginationStatus() -> Bool {
        return isPaginating
    }
    
    
    func selectedItems(row: Int) {
        guard sortArr.indices.contains(row) else {return}
        self.doctorArr = []
        self.pageForPagination = 1
        self.sortType = sortArr[row]
        view.addSelectedItem(self.sortType)
        getSearchResultDataWithFiltersWithPagination(pagination: true)
        
    }
    
    func doctorFilterPicker() -> [String] {
        return sortArr
    }
    
    func addFavoritesuccessfully(index: Int) {
        addFavoriteDoctor(index: index)
    }
    
    func doctorCellCount() -> Int {
        return doctorArrCellCount()
    }
    
    func tableViewCellConfiguration(cell: TableViewCellProtocol, index: Int) {
        let address = "\(self.doctorArr[index].region ?? ""): \(self.doctorArr[index].address ?? "")"
        downloadImage(for: index){ image in
            cell.cellConfigre(image: image ?? UIImage(), name: self.doctorArr[index].name ?? "", rating: self.doctorArr[index].rating ?? 0 , reviews: self.doctorArr[index].reviewsCount ?? 0 , bio: self.doctorArr[index].secondBio ?? "", specialist: self.doctorArr[index].specialty ?? "", address: address, time: self.doctorArr[index].waitingTime ?? 0 , fees: self.doctorArr[index].fees ?? 0, isFavorited: self.doctorArr[index].isFavorited ?? false )
        }
    }
}
