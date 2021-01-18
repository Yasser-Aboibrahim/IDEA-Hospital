//
//  AlertView.swift
//  IDEA Hospital
//
//  Created by yasser on 1/6/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import UIKit

protocol AlertViewControllerDelegate: class{
    func sendUserBookConfirmation(isConfirmed: Bool)
    func sendAppointmentComfirmCancellation(cancelStatus: Int)
}

enum AlertTypes{
    case confirmButton(timeStamp: Int ,docName: String)
    case twoButtons
    case successButton
    case failButton
    case defaultAlert(title: String)
    case defaultAlertTwoButtons(title: String)
}

class AlertViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var AlertView: AlertView!
    weak var delegate: AlertViewControllerDelegate?
    
    //MARK:- Properties
    var type: AlertTypes!
    var message: String!
    var buttonTitle: String!
    var completion: (()->Void)?
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AlertView.setup(type: type,message: message, buttonTitle: buttonTitle)
    }

    //MARK:- Public Methods
    class func create(type: AlertTypes)->AlertViewController{
        let alertViewController = AlertViewController()
        return alertViewController
    }
    
    //MARK:- Actions
    @IBAction func confirmBtnTapped(_ sender: CommonButton) {
        self.bookDoctorAppointment(type: self.type)
    }

    @IBAction func noBtnTapped(_ sender: CommonButton) {
        noBtnTapepd(type: self.type)
    }
    
    @IBAction func yesBtnTapped(_ sender: CommonButton) {
        yesBtnTapepd(type: self.type)
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        dismiss(animated: true){
            self.delegate?.sendAppointmentComfirmCancellation(cancelStatus: 2)
        }
    }
    
    
    //MARK:- Private Methods
    private func bookDoctorAppointment(type: AlertTypes) {
        switch type{
        case .confirmButton:
            dismiss(animated: true){
                self.delegate?.sendUserBookConfirmation(isConfirmed: true)
            }
        default:
            if let completion = self.completion{
                completion()
            }else{
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func noBtnTapepd(type: AlertTypes) {
        switch type{
        case .twoButtons:
            dismiss(animated: true){
                self.delegate?.sendAppointmentComfirmCancellation(cancelStatus: 1)
            }
        default:
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func yesBtnTapepd(type: AlertTypes) {
        switch type{
        case .twoButtons:
            dismiss(animated: true){
                self.delegate?.sendAppointmentComfirmCancellation(cancelStatus: 0)
            }
        default:
            if let completion = self.completion{
                completion()
            }
        }
    }
}
