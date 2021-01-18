//
//  HomeViewModel.swift
//  IDEA Hospital
//
//  Created by yasser on 12/9/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation
import SDWebImage

protocol HomeViewModelProtocol: class{
    func getMainCategoriesData()
    func getArrCategoriesCount() -> Int
    func configure(cell: HomeCellProtocol, index: Int)
    func categorySelection(index: Int)
}

class HomeViewModel{
    
    //MARK:- Properties
    private weak var view: HomeVCProtocol!
    private var categories = [MainCategory]()
    
    init(view: HomeVCProtocol){
        self.view = view
    }
    
    // MARK:- Private Methods
    private func getMainCategories(){
        view.showLoader()
        APIManager.getMainCategories{ (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Loading Error", title: "OK")
            case .success(let result):
                self.categories = result.data
                self.view.reloadData()
                print(result)
            }
                self.view.hideLoader()
        }
    }
    
   private func downloadImage(for Index: Int, completion: @escaping (UIImage?) -> Void) {
        view?.showLoader()
        SDWebImageManager.shared.loadImage(with: URL(string: categories[Index].image), options: .highPriority, progress: nil) {[weak self] (image, _, error, _, _, _) in
            if let error = error {
                print(error.localizedDescription)
            } else if let image = image {
                completion(image)
            }
            self?.view?.hideLoader()
        }
    }
}

// Mark:- Extension HomeViewModel Protocol funcs
extension HomeViewModel: HomeViewModelProtocol{
    
    func getMainCategoriesData() {
        getMainCategories()
    }
    
    func categorySelection(index: Int){
        // go to search screen with category id
        let id = categories[index].id
        switch id {
        case 4:
            view.goToNurseVC()
            print("go to nurse screen")
        default:
            view.goToSearchScreen(id: id)
        }
    }
    
    func getArrCategoriesCount() -> Int{
        return categories.count
    }
    
    func configure(cell: HomeCellProtocol, index: Int){
        downloadImage(for: index){ image in
            cell.cellCofiguration(name: self.categories[index].name, image: image, color: self.categories[index].color)

        }
    }
}

