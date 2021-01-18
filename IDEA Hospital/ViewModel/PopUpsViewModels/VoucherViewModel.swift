//
//  VoucherViewModel.swift
//  IDEA Hospital
//
//  Created by Hossam Yasser on 12/31/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation



//MARK:- VoucherViewModelProtocol
protocol VoucherViewModelProtocol : class {
    func doctorBooking(voucher: String, name: String, bookForAnother: Bool)
    func getDoctorDataWithId()
    func getNameState(nameEntered: Bool)
    func getVoucherState(voucherEntered: Bool)
}

class VoucherViewModel{
    //MARK:- Properties
    private weak var view: VoucherVCProtocol!
    private var appointmentTimeStamp: Int
    private var doctorId: Int
    private var docName: String!
    private var voucherState: Bool = true
    private var nameState: Bool = true
    private var voucherValue: String? = nil
    
    init(view: VoucherVCProtocol, appointmentTimeStamp: Int, doctorId: Int){
        self.view = view
        self.appointmentTimeStamp = appointmentTimeStamp
        self.doctorId = doctorId
    }
}

//MARK:- Extension Private Methods
extension VoucherViewModel{
    
    private func getDoctorDataWithIdPM(){
        APIManager.getDoctorData(doctorId: doctorId){ (response) in
            switch response{
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            case .success(let result):
                print(result)
                self.docName = result.data.name
            }
        }
    }
    
    private func dataValiddation(patientName: String, voucher: String) ->Bool {
        
        if voucherState{
            if !ValidationManager.shared().isEmptyComment(comment: voucher) {
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Voucher", title: "ok")
                return false
            }else{
                voucherValue = voucher
            }
        }
        
        if nameState{
        if !ValidationManager.shared().isEmptyComment(comment: patientName) {
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Patient Name is required", title: "ok")
            return false
            }
        }
        
        return true
    }
    
    private func bookDoctorAppointment(voucher: String, name: String , bookForAnother: Bool) {
        
        
        view.sendDataToDoctorProfileVC(voucher: self.voucherValue, name: name, bookForAnother: bookForAnother)
    }
}

//MARK:- VoucherViewModel Protocol funcs
extension VoucherViewModel: VoucherViewModelProtocol {
    func getNameState(nameEntered: Bool) {
        self.nameState = nameEntered
    }
    
    func getVoucherState(voucherEntered: Bool) {
        self.voucherState = voucherEntered
    }
    
    
    func getDoctorDataWithId(){
         getDoctorDataWithIdPM()
    }
    
    func doctorBooking(voucher: String, name: String, bookForAnother: Bool){
        if dataValiddation(patientName: name, voucher: voucher){
        bookDoctorAppointment(voucher: voucher, name: name, bookForAnother: bookForAnother)
        }
    }
}

