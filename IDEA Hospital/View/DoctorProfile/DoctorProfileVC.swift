//
//  DoctorProfileVC.swift
//  IDEA Hospital
//
//  Created by yasser on 12/30/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

//MARK:- DoctorProfileVC Protocol
protocol DoctorProfileVCProtocol: class{
    func showLoader()
    func hideLoader()
    func setDoctorData(doctorImage: UIImage, doctorName: String, doctorBio: String, doctorRate: Int, reviews: Int, doctorSecondBio: String, address: String, time: Int, fees: Int, companies: String, speciality: String, isFavorite: Bool)
    func reloadData()
    func reloadDataTableView()
    func bookDayLabel(date: String)
    func tableFooterViewWithPagination()
    func bookTimeData(isAvailabel: Bool)
    func goToReviewVC(doctorId: Int)
    func goToVoucherVC(appintmentTimeStamp: Int, doctorId: Int)
    func showCusromAlert(type: AlertTypes, message: String, title: String)
    func gotoPopUpVC(doctorId: Int, appointmentTimeStamp: String)
}
class DoctorProfileVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var doctorProfileView: DoctorProfileView!
    
    //MARK:- Properties
    private var viewModel: DoctorProfileViewModelProtocol!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        doctorProfileView.setup()
        setupBackground()
        setNavigation()
        viewModel.getDoctorDataWithId()
        viewModel.getDoctorAppointmentsWithId()
        setTableViewView()
        viewModel.getDoctorReviewsWithPagination(pagination: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTabBar()
        
    }
    
    //MARK:- Public Methods
    class func create(doctorId: Int) -> DoctorProfileVC {
        let doctorProfileVC: DoctorProfileVC = UIViewController.create(storyboardName: Storyboards.doctorProfile, identifier: ViewControllers.doctorProfileVC)
        doctorProfileVC.viewModel = DoctorProfileViewModel(view: doctorProfileVC, doctorId: doctorId)
        return doctorProfileVC
    }
    
    //MARK:- Actions
    @IBAction func nextDayBtnTapped(_ sender: UIButton) {
        doctorProfileView.nextOrBackDayBtnTapped()
        viewModel.nextDayButton()
    }
    
    @IBAction func backDayBtnTapped(_ sender: UIButton) {
        doctorProfileView.nextOrBackDayBtnTapped()
        viewModel.backDayButton()
    }
    
    @IBAction func bookNowBtnTapped(_ sender: UIButton) {
        // popup sure to book? with having the timestamp
        viewModel.goToVoucherVC()
    }
    
    @IBAction func doctorProfileBtnTapped(_ sender: UIButton) {
        doctorProfileView.doctorProfileBtnTapped()
    }
    
    @IBAction func doctorReviewsBtnTapped(_ sender: UIButton) {
        doctorProfileView.doctorReviewsBtnTapped()
    }
    
    @IBAction func viewOnMapBtnTapped(_ sender: UIButton) {
        viewModel.getMapLocation()
    }
    
    @IBAction func addAndRemoveFavoriteBtn(_ sender: UIButton) {
        viewModel.addAndRemoveFavorites()
        doctorProfileView.favoriteBtnViewAfterPress()
    }
    
    @IBAction func tabReviewBtnTapped(_ sender: UIButton) {
        viewModel.goToReviewVC()
    }
}

//MARK:- Extension Private Methods
extension DoctorProfileVC{
    private func setCollectionView(){
        doctorProfileView.doctorProfileCollectionView.delegate = self
        doctorProfileView.doctorProfileCollectionView.dataSource = self
    }
    
    private func setTableViewView(){
        doctorProfileView.doctorReviewsTabelView.delegate = self
        doctorProfileView.doctorReviewsTabelView.dataSource = self
    }
    
    private func setNavigation(){
        setupNavController(title: "Search Result", settingColor: false)
        setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: true)
    }
    
    private func setTabBar(){
        tabBarController?.tabBar.isHidden = false
        tabBarController?.selectedIndex = 0
    }
    
}

// MARK:- Extensions DoctorProfileVC
extension DoctorProfileVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! doctorProfileCollectionViewCell
        cell.selectTimeLabel()
        viewModel.getAppointmentToBook(index: indexPath.row)
        doctorProfileView.bookButtonSelectionState()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! doctorProfileCollectionViewCell
        cell.deSelectTimeLabel()
        doctorProfileView.bookButtonDeselectionState()
    }
}

//MARK:- Extensions CollectionView
extension DoctorProfileVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTimesArrCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.DoctorProfileCollectionViewCell, for: indexPath) as! doctorProfileCollectionViewCell
        viewModel.doctorProfileCollectionViewCellConfigure(cell: cell, index: indexPath.row)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 20.0
    }

    func collectionView(collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 20.0
    }
}

extension DoctorProfileVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenWidth = UIScreen.main.bounds.width
            return CGSize.init(width: (screenWidth-55) / 3.25, height: (screenWidth-55) / 3.25 / 4)
    }
}

//MARK:- Extension DoctorReviews TableView
extension DoctorProfileVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getReviewsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = doctorProfileView.doctorReviewsTabelView.dequeueReusableCell(withIdentifier: Cells.doctorReviewsTabelViewCell, for: indexPath) as! DoctorReviewsTabelViewCell
        viewModel.doctorProfileTableViewCellConfigure(cell: cell, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK:- Extension UIScrollView Delegate (Paginationg)
extension DoctorProfileVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (doctorProfileView.doctorReviewsTabelView.contentSize.height-100-scrollView.frame.size.height){
            // fetch more data
            guard !viewModel.paginationStatus() else{
                print("Already Fetching Data")
                return
            }
            doctorProfileView.doctorReviewsTabelView.tableFooterView = doctorProfileView.createSpinnerFooter()
            // call api and send true to pagination
            viewModel.getDoctorReviewsWithPagination(pagination: true)
        }
    }
}

//MARK:- Extension conform the VoucherVC delegate
extension DoctorProfileVC: VoucherVCDelegate{
    func continueBtnTapped(voucher: String?, patientName: String, bookForAnother: Bool) {
        viewModel.setBookingData(voucher: voucher, patientName: patientName, bookForAnother: bookForAnother)
    }
}

//MARK:- Extension conform the SignupAndLogin delegate
extension DoctorProfileVC: SignUpAndLoginPopUpDelegate{
    func getDoctorAppointments() {
        doctorProfileView.bookButtonDeselectionState()
        viewModel.getDoctorAppointmentsWithId()
    }
}

//MARK:- Extension conform the VoucherVC delegate
extension DoctorProfileVC: AlertViewControllerDelegate{
    func sendAppointmentComfirmCancellation(cancelStatus: Int) {
        viewModel.AppointmentComfirmCancellation(cancelStatus: cancelStatus)
    }
    
    func sendUserBookConfirmation(isConfirmed: Bool) {
        doctorProfileView.bookButtonDeselectionState()
        viewModel.userBookConfirmation(isConfirmed: isConfirmed)
    }
}

//MARK:- Extension DoctorProfileVC Protocol funcs
extension DoctorProfileVC: DoctorProfileVCProtocol{
    
    func gotoPopUpVC(doctorId: Int, appointmentTimeStamp: String) {
        openRegistrationPopUp(doctorId: doctorId, appointmentTimeStamp: appointmentTimeStamp)
    }
    
    func bookTimeData(isAvailabel: Bool) {
        doctorProfileView.bookTimeData(isAvailablel: isAvailabel)
    }
    
    
    func bookDayLabel(date: String) {
        doctorProfileView.bookDayLabel.text = date
    }
    
    func reloadData() {
        doctorProfileView.doctorProfileCollectionView.reloadData()
    }
    
    func reloadDataTableView(){
        doctorProfileView.doctorReviewsTabelView.reloadData()
    }
    
    
    func tableFooterViewWithPagination(){
        DispatchQueue.main.async { self.doctorProfileView.doctorReviewsTabelView.tableFooterView = nil
        }
    }
    
    func showLoader() {
        view.showLoading()
    }
    
    func hideLoader() {
        view.hideLoading()
    }

    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
    
    func setDoctorData(doctorImage: UIImage, doctorName: String, doctorBio: String, doctorRate: Int, reviews: Int, doctorSecondBio: String, address: String, time: Int, fees: Int, companies: String, speciality: String, isFavorite: Bool){
        doctorProfileView.setDoctorData(doctorImage: doctorImage, doctorName: doctorName, doctorBio: doctorBio, doctorRate: doctorRate, reviews: reviews, doctorSecondBio: doctorSecondBio, address: address, time: time, fees: fees, companies: companies, speciality: speciality, isFavorite: isFavorite)
    }
    
    func goToReviewVC(doctorId: Int){
        let reviewVC = ReviewVC.create(doctorId: doctorId)
        navigationController?.pushViewController(reviewVC, animated: true)
    }
    
    func goToVoucherVC(appintmentTimeStamp: Int, doctorId: Int){
            let voucherVC = VoucherVC.create(appointmentTimeStamp: appintmentTimeStamp, doctorId: doctorId)
            voucherVC.delegate = self
            voucherVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            voucherVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            present(voucherVC, animated: true, completion: nil)
    }
}
