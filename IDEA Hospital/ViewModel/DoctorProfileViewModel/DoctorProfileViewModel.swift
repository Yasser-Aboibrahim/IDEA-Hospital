//
//  DoctorProfileViewModel.swift
//  IDEA Hospital
//
//  Created by yasser on 12/30/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation
import SDWebImage

//MARK:- DoctorProfileViewModel Protocol
protocol DoctorProfileViewModelProtocol: class{
    func getDoctorDataWithId()
    func getDoctorAppointmentsWithId()
    func nextDayButton()
    func backDayButton()
    func getTimesArrCount()->Int
    func doctorProfileCollectionViewCellConfigure(cell: DoctorProfileCollectionViewCellProtocol, index: Int)
    func bookTimeIndex(index: Int)
    func getMapLocation()
    func getDoctorReviewsWithPagination(pagination: Bool)
    func paginationStatus() -> Bool
    func getReviewsCount()-> Int
    func doctorProfileTableViewCellConfigure(cell: DoctorReviewsTabelViewCellProtocol, index: Int)
    func getAppointmentToBook(index: Int)
    func addAndRemoveFavorites()
    func goToReviewVC()
    func goToVoucherVC()
    func setBookingData(voucher: String?, patientName: String, bookForAnother: Bool)
    func userBookConfirmation(isConfirmed: Bool)
    func AppointmentComfirmCancellation(cancelStatus: Int)
}

class DoctorProfileViewModel{
    //MARK:- Properties
    private weak var view: DoctorProfileVCProtocol!
    private var doctorId: Int
    private var doctorData: Doctor!
    private var doctorAppointmentsDayArr = [DocotorAppointments]()
    private var doctorAppointmentsTimeArr = [DocotorAppointmentsTime]()
    private var index: Int = 0
    private var bookTimeIndex: Int!
    private var bookDateIndex: Int!
    private var companies: String!
    private var isPaginating = false
    private var pageForPagination = 1
    private var perPageForPagination = 10
    private var doctorReviewsArr = [DocotorReviews]()
    private var appintmentTimeStamp: Int!
    private var voucher: String!
    private var patientName: String!
    private var bookForAnother: Bool!
    
    init(view: DoctorProfileVCProtocol, doctorId: Int){
        self.view = view
        self.doctorId = doctorId
    }
    
}

//MARK:- Extension Private Methods
extension DoctorProfileViewModel{
    private func downloadImage(completion: @escaping (UIImage?) -> Void) {
        view?.showLoader()
        SDWebImageManager.shared.loadImage(with: URL(string: doctorData.image!), options: .highPriority, progress: nil) {[weak self] (image, _, error, _, _, _) in
            if let error = error {
                print(error.localizedDescription)
            } else if let image = image {
                completion(image)
            }
            self?.view?.hideLoader()
        }
    }
    
    private func getDoctorData(){
        downloadImage(){ image in
            let address = "\(self.doctorData.region ?? ""): \(self.doctorData.address ?? "")"
            self.companies = ""
            for company in self.doctorData?.companies ?? []{
                self.companies = self.companies + ", " + company
            }
            self.view.setDoctorData(doctorImage: image!, doctorName: self.doctorData.name ?? "", doctorBio: self.doctorData.bio ?? "", doctorRate: self.doctorData.rating ?? 0, reviews: self.doctorData.reviewsCount ?? 0, doctorSecondBio: self.doctorData.secondBio ?? "", address: address, time: self.doctorData.waitingTime ?? 0, fees: self.doctorData.fees ?? 0, companies: self.companies, speciality: self.doctorData.specialty ?? "", isFavorite: self.doctorData.isFavorited ?? false)
        }
    }
    
    private func getDayTimes(){
        doctorAppointmentsTimeArr = []
        for times in doctorAppointmentsDayArr[index].times{
            doctorAppointmentsTimeArr.append(times)
        }
        if doctorAppointmentsTimeArr.isEmpty{
            view.bookTimeData(isAvailabel: false)
        }else{
            view.bookTimeData(isAvailabel: true)
        }
        self.bookDateIndex = self.index
        let apiDate = Date(timeIntervalSinceNow: TimeInterval(self.doctorAppointmentsDayArr[self.index].date))
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "EEEE, MMM d, yyyy"
        let date = "\(formatterDate.string(from: apiDate))"
        view.bookDayLabel(date: date)
        view.reloadData()
    }
    
    private func doctorProfileTableViewCellConfigurePM(cell: DoctorReviewsTabelViewCellProtocol, index: Int){
        cell.cellConfigure(name: doctorReviewsArr[index].commentedBy, comment: doctorReviewsArr[index].comment, rating: doctorReviewsArr[index].rating)
    }
    
    private func bookTimeIndexPM(index: Int){
        self.bookTimeIndex = index
    }
    
    private func getTimesArrCountPM() -> Int{
        return doctorAppointmentsTimeArr.count
    }
    
    private func doctorProfileCollectionViewCellConfigurePM(cell: DoctorProfileCollectionViewCellProtocol, index: Int){
        cell.cellCongigure(time: doctorAppointmentsTimeArr[index].time, isBooked: doctorAppointmentsTimeArr[index].booked)
    }
    
    private func nextDayButtonPM(){
        index = index + 1
        if  index > (doctorAppointmentsDayArr.count - 1){
            index = 0
        }
        getDayTimes()
    }
    
    private func backDayButtonPM(){
        index = index - 1
        if  index < 0{
            index = (doctorAppointmentsDayArr.count - 1)
        }
        getDayTimes()
    }
    
    private func getDoctorDataWithIdPM(){
        view.showLoader()
        APIManager.getDoctorData(doctorId: doctorId){ (response) in
            switch response{
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Loading Error", title: "OK")
            case .success(let result):
                print(result)
                self.doctorData = result.data
                self.getDoctorData()
            }
            self.view.hideLoader()
        }
    }
    
    private func getDoctorAppointmentsWithIdPM(){
        doctorAppointmentsDayArr = []
        doctorAppointmentsTimeArr = []
        view.showLoader()
        APIManager.getDoctorAppointments(doctorId: doctorId){ (response) in
            switch response{
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Loading Error", title: "OK")
            case .success(let result):
                print(result)
                self.doctorAppointmentsDayArr = result.data
                for times in self.doctorAppointmentsDayArr[0].times{
                    self.doctorAppointmentsTimeArr.append(times)
                }
                let apiDate = Date(timeIntervalSince1970: TimeInterval(self.doctorAppointmentsDayArr[self.index].date))
                let formatterDate = DateFormatter()
                formatterDate.dateFormat = "EEEE, MMM d, yyyy"
                let date = "\(formatterDate.string(from: apiDate))"
                self.view.bookDayLabel(date: date)
                self.view.reloadData()
            }
            self.view.hideLoader()
        }
    }
    
    private func getMapLocationPM(){
        let lat = doctorData.lat
        let lng = doctorData.lng
        let locationName = doctorData.address
        LocationOnMap.openMap(lat: lat!, lng: lng!, theLocationName: locationName!)
    }
    
    private func getDoctorReviewsWithPaginationPM(pagination: Bool){
        view.showLoader()
        if pagination{
            isPaginating = true
        }
        APIManager.getDoctorReviewsWithPagination(pega: pageForPagination, perPage: perPageForPagination, doctorId: self.doctorId){ (response) in
            self.view.tableFooterViewWithPagination()
            switch response{
            case .failure(let error):
                print(error)
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Loading Error", title: "OK")
            case .success(let result):
                guard !result.data.items.isEmpty else{
                    self.isPaginating = false
                    self.view.hideLoader()
                    return
                }
                
                for itemData in result.data.items{
                    self.doctorReviewsArr.append(itemData)
                }
                
                self.pageForPagination = self.pageForPagination + 1
                
                if pagination{
                    self.isPaginating = false
                }
                self.view.reloadDataTableView()
                print(result)
            }
            self.view.hideLoader()
        }
    }
    
    private func andAndRemoveFavoritesData(){
        if UserDefaultsManager.shared().token != nil {
            view.showLoader()
            APIManager.addAndRemoveFavorite(id: self.doctorId){ (response) in
                switch response{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Loading Error", title: "OK")
                case .success(let result):
                    print(result)
                }
                self.view.hideLoader()
            }
        }else{
            view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please LogIn First", title: "Ok")
        }
        
    }
    
    private func bookAppointment(isConfirmed: Bool){
        let body = UserDoctorAppointment(doctorId: self.doctorId, appointment: String(self.appintmentTimeStamp), bookForAnother: self.bookForAnother, patientName: self.patientName, voucher: self.voucher)
        if isConfirmed{
        APIManager.bookDoctor(body: body){ (response) in
            switch response {
            case .failure (let error):
                print(error.localizedDescription)
                print(error)
                self.view.showCusromAlert(type: .failButton, message: "Appointment failed To Booked…Try again", title: "ok")
                
            case .success(let result):
                print(result)
                if result.code == 422 {
                    self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "The selected voucher is invalid", title: "OK")
                }else{
                self.view.showCusromAlert(type: .successButton, message: "Appointment Successfully Booked", title: "ok")
                        self.getDoctorAppointmentsWithId()
                }
            }
        }
        }else{
            return
        }
    }
    
    private func appointmentComfirmCancellationPM(cancelStatus: Int){
        switch cancelStatus{
        case 1:
            self.view.showCusromAlert(type: .confirmButton(timeStamp: self.appintmentTimeStamp, docName: self.doctorData.name!), message: "", title: "Confirm")
        case 2:
            self.view.showCusromAlert(type: .twoButtons, message: "", title: "")
        default:
            return
        }
    }
    
    private func paginationStatusPM() -> Bool {
        return isPaginating
    }
    
    private func getReviewsCountPM()-> Int{
        return self.doctorReviewsArr.count
    }
    
    private func getAppointmentToBookPM(index: Int){
        self.appintmentTimeStamp = doctorAppointmentsTimeArr[index].time
    }
    
    private func goToReviewVCPM(){
        if UserDefaultsManager.shared().token != nil{
            view.goToReviewVC(doctorId: self.doctorId)
        }else{
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please SignIn", title: "OK")
        }
    }
}

//MARK:- Extension DoctorProfileViewModel Protocol funcs
extension DoctorProfileViewModel: DoctorProfileViewModelProtocol{
    func AppointmentComfirmCancellation(cancelStatus: Int) {
        appointmentComfirmCancellationPM(cancelStatus: cancelStatus)
    }
    
    func userBookConfirmation(isConfirmed: Bool) {
        bookAppointment(isConfirmed: isConfirmed)
    }
    
    func setBookingData(voucher: String?, patientName: String, bookForAnother: Bool) {
        self.voucher = voucher
        self.patientName = patientName
        self.bookForAnother = bookForAnother
        self.view.showCusromAlert(type: .confirmButton(timeStamp: self.appintmentTimeStamp, docName: self.doctorData.name!), message: "", title: "Confirm")
    }
    
    
    func goToVoucherVC(){
        if UserDefaultsManager.shared().token != nil {
           view.goToVoucherVC(appintmentTimeStamp: self.appintmentTimeStamp, doctorId: self.doctorId)
        }else{
            view.gotoPopUpVC(doctorId: self.doctorId,appointmentTimeStamp: String(self.appintmentTimeStamp))
        }
        
    }
    func goToReviewVC(){
        goToReviewVCPM()
    }
    func doctorProfileTableViewCellConfigure(cell: DoctorReviewsTabelViewCellProtocol, index: Int) {
        doctorProfileTableViewCellConfigurePM(cell: cell, index: index)
    }
    
    func bookTimeIndex(index: Int) {
        bookTimeIndexPM(index: index)
    }
    
    func getTimesArrCount() -> Int {
        return getTimesArrCountPM()
    }
    
    func doctorProfileCollectionViewCellConfigure(cell: DoctorProfileCollectionViewCellProtocol, index: Int) {
        doctorProfileCollectionViewCellConfigurePM(cell: cell, index: index)
    }
    
    func nextDayButton(){
        nextDayButtonPM()
    }
    
    func backDayButton() {
        backDayButtonPM()
    }
    
    
    func getDoctorDataWithId(){
        getDoctorDataWithIdPM()
    }
    
    func getDoctorAppointmentsWithId(){
        getDoctorAppointmentsWithIdPM()
    }
    
    func getMapLocation(){
        getMapLocationPM()
    }
    
    func getDoctorReviewsWithPagination(pagination: Bool){
        getDoctorReviewsWithPaginationPM(pagination: pagination)
    }
    
    func paginationStatus() -> Bool {
        return paginationStatusPM()
    }
    
    func getReviewsCount()-> Int{
        return getReviewsCountPM()
    }
    
    func getAppointmentToBook(index: Int){
        getAppointmentToBookPM(index: index)
    }
    
    func addAndRemoveFavorites() {
        andAndRemoveFavoritesData()
    }
    
}
