//
//  viewModel.swift
//  IDEA_Hospital_Team4
//
//  Created by Hossam on 12/8/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

protocol SearchServicesViewModelProtocol: class{
    func prepareCategories()
    func pickerItem(with tag: Int)
    func selectedItems(tag: Int , row: Int)
    func itemsCount() -> Int
    func getItems(row: Int) -> String
    func goToSearchResultVC(doctorName: String?)
}

class SearchSearvicesViewModel {
    
    // MARK:- Properties
    private weak var view: SearchServicesVCProtocol!
    private var allCategoriesData : categoryDataResponse!
    private var specialityID: Int?
    private var cityID: Int?
    private var regionID: Int?
    private var companyID: Int?
    private var items: [String] = []
    private var categoryId: Int?
   
    
    init(view: SearchServicesVCProtocol,categoryId: Int){
     self.view = view
     self.categoryId = categoryId
    }
}

// MARK:- Private Methods
extension SearchSearvicesViewModel {
    
    private func getMainCategoriesParams() {
    view.showLoader()
        APIManager.getquerypParametersData(with: self.categoryId ?? 0){ [weak self] (response) in
        switch response {
        case .failure(let error):
            print(error.localizedDescription)
            self!.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Loading Error", title: "OK")
        case .success(let result):
         print(result.data.cities)
            self?.allCategoriesData = result.data
        }
            self?.view.hideLoader()
    }
}
    
}

// Mark:- Extension
extension SearchSearvicesViewModel: SearchServicesViewModelProtocol {
    
    func goToSearchResultVC(doctorName: String?) {
        view.goToSearchResultVC(categoryId: self.categoryId!, specialtyId:self.specialityID, cityId:self.cityID, regionId:self.regionID, companyId: self.companyID, name: doctorName)
    }
    
    func prepareCategories() {
        getMainCategoriesParams()
    }
    
    func pickerItem(with tag: Int) {
        guard allCategoriesData != nil else {return}
            switch tag {
            case 1:
                items = allCategoriesData.specialties.map{$0.name}
            case 2: items = allCategoriesData.cities.map{$0.name}
            case 3:
                if let city = allCategoriesData.cities.first(where: {$0.id == cityID}) {
                    items = city.regions.map{$0.name}
                    view.doneButtonEnabled (true, for: tag)
                } else {
                    //items = ["choose Your City"]
                    view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Choose City", title: "OK")
                    view.doneButtonEnabled (false, for: tag)
                }
            case 4:
                items = allCategoriesData.companies.map{$0.name}
            default: break
        }
        view.showItems()
        }
    
    func selectedItems(tag: Int, row: Int) {
        guard items.indices.contains(row) else {return}
        switch tag {
        case 1: let speciality = allCategoriesData.specialties[row]
            view?.addSelectedItem(tag, speciality.name)
            specialityID = speciality.id
        case 2:
            let city = allCategoriesData.cities[row]
            view?.addSelectedItem(tag, city.name)
            if city.id == cityID{
                break
            }
            cityID = city.id
            view?.clearTextField(with:3)
            
            case 3:
                if let city = allCategoriesData.cities.first(where: {$0.id == cityID}) {
                let region = city.regions[row]
                view?.addSelectedItem(tag, region.name)
                regionID = region.id
            }
        view?.addSelectedItem(tag, items[row])
        case 4:
        let company = allCategoriesData.companies[row]
        view?.addSelectedItem(tag, company.name)
        companyID = company.id
        default: break
        }
    }
    func itemsCount() -> Int {
        return  items.count
    }
    
    func getItems(row: Int)-> String {
        return items[row]
    }
}








