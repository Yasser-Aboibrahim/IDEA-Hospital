//
//  ReviewViewModel.swift
//  IDEA Hospital
//
//  Created by Hossam Yasser on 12/30/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

//MARK:- ReviewViewModel Protocol
protocol ReviewViewModelProtocol : class {
    func sendReview(rating: Int , comment: String)
}

class ReviewViewModel{
    //MARK:- Properties
    private weak var view: ReviewVCProtocol!
    private var doctorId: Int
    
    init(view: ReviewVCProtocol, doctorId: Int){
        self.view = view
        self.doctorId = doctorId
    }
}

//MARK:- Extension Private Methods
extension ReviewViewModel{
    private func dataValiddation(comment: String) ->Bool {
        if !ValidationManager.shared().isEmptyComment(comment: comment) {
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Comment is required", title: "OK")
            return false
        }
        return true
    }
    
    private func sendDoctorReview(rating: Int , comment: String) {
        APIManager.review(id: self.doctorId, rating: rating, comment: comment){ (response) in
            switch response {
            case .failure (let error):
                print(error.localizedDescription)
                print(error)
            case .success(let result):
                print(result)
                self.view.showCusromAlert(type: .defaultAlert(title: "successfully"), message: "Thanks for your review", title: "OK")
            }
        }
    }
}

//MARK:- Extension ReviewViewModel Protocol funcs
extension ReviewViewModel: ReviewViewModelProtocol {
    func sendReview(rating: Int , comment: String){
        if dataValiddation(comment: comment){
        sendDoctorReview(rating: rating, comment: comment)
        }
    }
    }
    
