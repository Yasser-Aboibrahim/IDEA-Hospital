//
//  VoucherVC.swift
//  IDEA Hospital
//
//  Created by Hossam Yasser on 12/31/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

protocol VoucherVCDelegate: class{
    func continueBtnTapped(voucher: String?,patientName: String ,bookForAnother: Bool)
}

protocol  VoucherVCProtocol: class {
    func showCusromAlert(type: AlertTypes, message: String, title: String)
    func sendDataToDoctorProfileVC(voucher: String?, name: String , bookForAnother: Bool)
}


class VoucherVC: UIViewController {
    
    //Mark:- Outlets
    @IBOutlet weak var VoucherView: VoucherView!
    
    // MARK:- Properties
    private var viewModel: VoucherViewModelProtocol!
    weak var delegate: VoucherVCDelegate?
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        VoucherView.setup()
        viewModel.getDoctorDataWithId()
        navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK:- Public Methods
    class func create(appointmentTimeStamp: Int, doctorId: Int) -> VoucherVC {
        let voucherVC: VoucherVC = UIViewController.create(storyboardName: Storyboards.popUpVoucher, identifier: ViewControllers.voucherVC)
        voucherVC.viewModel = VoucherViewModel(view:  voucherVC, appointmentTimeStamp: appointmentTimeStamp, doctorId: doctorId)
        return voucherVC
    }
    
    //MARK:- Actions
    @IBAction func firstSwitch(_ sender: UISwitch) {
        if sender.isOn{
            viewModel.getVoucherState(voucherEntered: VoucherView.firstSwitchIsOn())
        }else{
            viewModel.getVoucherState(voucherEntered: VoucherView.firstSwitchNotIsOn())
        }
    }
    
    @IBAction func secondSwitch(_ sender: UISwitch) {
        if sender.isOn{
            viewModel.getNameState(nameEntered: VoucherView.secondSwitchIsOn())
            
        }else{
            viewModel.getNameState(nameEntered: VoucherView.secondSwitchNotIsOn())
        }
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        
        viewModel.doctorBooking(voucher: VoucherView.enterCodeTextField.text!, name: VoucherView.enterNameTextField.text! , bookForAnother: VoucherView.secondSwitch.isOn)
    }
}

//MARK:- Extension VoucherVC Protocol funcs
extension VoucherVC: VoucherVCProtocol{
    
    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
    
    func sendDataToDoctorProfileVC(voucher: String?, name: String , bookForAnother: Bool){
        self.dismiss(animated: true){
            self.delegate?.continueBtnTapped(voucher: voucher, patientName: name, bookForAnother: bookForAnother)
        }
    }
}
