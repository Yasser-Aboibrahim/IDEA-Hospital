//
//  ReviewVC.swift
//  IDEA Hospital
//
//  Created by Hossam Yasser on 12/30/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit
//MARK:- ReviewVC Protocol
protocol ReviewVCProtocol: class {
    func showCusromAlert(type: AlertTypes, message: String, title: String)
    func goToDoctorProfile()
}

class ReviewVC: UIViewController {
    //Mark:- Outlets
    @IBOutlet weak var ReviewView: ReviewView!
  
    // MARK:- Properties
    private var viewModel: ReviewViewModelProtocol!
    
    //Mark:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        ReviewView.setup()
        setNavigation()
        setTabBar()
        ReviewView.drRatingCosmos.didFinishTouchingCosmos = {rating in
        print(rating)
        }
    }
    
    //MARK:- Public Methods
    class func create(doctorId: Int) -> ReviewVC {
        let reviewVC: ReviewVC = UIViewController.create(storyboardName: Storyboards.review, identifier: ViewControllers.reviewVC)
        reviewVC.viewModel = ReviewViewModel(view: reviewVC, doctorId: doctorId)
        return reviewVC
    }

    //MARK:- Actions
    @IBAction func submitReviewButtonTapped(_ sender: UIButton) {
        viewModel.sendReview(rating: Int(ReviewView.drRatingCosmos.rating),  comment: ReviewView.addCommentTextField.text!)
    }
    
    private func setNavigation(){
        setupNavController(title: "REVIEW", settingColor: false)
        setupNavigationItems(backAction: .dismissCurrent, haveSettingBTN: true)
    }
    
    private func setTabBar(){
        tabBarController?.tabBar.isHidden = false
        tabBarController?.selectedIndex = 0
    }
}

//MARK:- Extension ReviewVCProtocol Funcs
extension ReviewVC: ReviewVCProtocol{
    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
    
    func goToDoctorProfile() {
        navigationController?.popViewController(animated: true)
    }
}

