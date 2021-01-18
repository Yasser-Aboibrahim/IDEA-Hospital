//
//  ViewController.swift
//  IDEA Hospital
//
//  Created by yasser on 12/6/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

// MARK:- HomeVC protocol
protocol HomeVCProtocol: class{
    func showLoader()
    func hideLoader()
    func reloadData()
    func goToSearchScreen(id: Int)
    func goToNurseVC()
    func showCusromAlert(type: AlertTypes, message: String, title: String)
}

class HomeVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var homeView: HomeView!

    //MARK:- Properties
    private var viewModel: HomeViewModelProtocol!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        viewModel.getMainCategoriesData()
        setupBackground()
        homeView.setup()
        setupNavController(title: "Choose Service", settingColor: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- Public Methods
    class func create() -> HomeVC {
        let homeVC: HomeVC = UIViewController.create(storyboardName: Storyboards.home, identifier: ViewControllers.homeVC)
        homeVC.viewModel = HomeViewModel(view: homeVC)
        return homeVC
    }
}

// MARK:- Extensions collectionView protocol funcs
extension HomeVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.categorySelection(index: indexPath.row)
    }
}

extension HomeVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getArrCategoriesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.homeCell, for: indexPath) as! HomeCell
        viewModel.configure(cell: cell, index: indexPath.row)
        return cell
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = calculationWidth()
       return CGSize(width: width, height: width)
    }
}

// MARK:- Extension Private methods
extension HomeVC{
    // width calculation private method
    private func calculationWidth() -> CGFloat {
        let estimateWidth = CGFloat(150.0)
        let cellCount = floor(CGFloat(view.frame.size.width/estimateWidth))
        let margin = CGFloat(40.0)
        let width = (view.frame.size.width - CGFloat(40.0) * (cellCount - 1) - margin) / cellCount
        return width
    }
    
    private func setCollectionView(){
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
    }
    
    private func goToSearchScreenVC(id: Int){
        let tabBarVC = TabBarVC.create(categoryID: id)
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true, completion: nil)
    }
    
    private func goToNurseScreen() {
        let nurseVC = HomeNurseVC.create(screenType: ScreenType.homeNurse)
        navigationController?.pushViewController(nurseVC, animated: true)
    }
}

// MARK:- HomeVC protocol funcs
extension HomeVC: HomeVCProtocol{
    func goToSearchScreen(id: Int) {
        goToSearchScreenVC(id: id)
    }
    
    func goToNurseVC() {
        goToNurseScreen()
    }
    
    func reloadData() {
        homeView.collectionView.reloadData()
    }
    
    func showLoader() {
        self.view.showLoading()
    }
    
    func hideLoader() {
        self.view.hideLoading()
    }
    
    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
}

