//
//  AlertView.swift
//  IDEA Hospital
//
//  Created by yasser on 1/6/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class AlertView: UIView {
 
    //MARK:- Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var alertImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var yesBtn: CommonButton!
    @IBOutlet weak var confirmBtn: CommonButton!
    @IBOutlet weak var noBtn: CommonButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    //MARK:- Public Methods
    func setup(type: AlertTypes,message: String, buttonTitle: String){
        setupType(type: type)
        setupContainerView()
        setupBtn(btnTitle: buttonTitle)
        titleAndMessageSetup(type: type, message: message)
        
    }
}

//MARK:- Extension Private Methods
extension AlertView{
    private func titleAndMessageSetup(type: AlertTypes, message: String){
        switch type{
        case .confirmButton(let timeStamp,let docName):
            setupConfirmMessage(timeStamp: timeStamp, docName: docName)
        case .defaultAlert(let title):
            setupTitleLabel(title: title)
            setupMessage(message: message)
        case .twoButtons:
            setupTitleLabel(title: "Are you sure you want to cancel this appointment?")
        case .defaultAlertTwoButtons(let title):
            setupTitleLabel(title: title)
        default:
            setupMessage(message: message)
        }
    }
    private func setupType(type: AlertTypes){
        switch type{
        case .defaultAlertTwoButtons:
            confirmBtn.isHidden = true
            yesBtn.isHidden = false
            noBtn.isHidden = false
            noBtn.backgroundColor = UIColor(red: 111.0 / 255.0, green: 4.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
            noBtn.setTitle("No", for: .normal)
            yesBtn.setTitle("Yes", for: .normal)
            alertImageView.isHidden = true
            cancelBtn.isHidden = true
            messageLabel.isHidden = true
        case .defaultAlert:
            confirmBtn.isHidden = false
            yesBtn.isHidden = true
            noBtn.isHidden = true
            alertImageView.isHidden = true
            alertImageView.contentMode = .scaleToFill
            cancelBtn.isHidden = true
            
        case .confirmButton:
            confirmBtn.isHidden = false
            cancelBtn.isHidden = false
            yesBtn.isHidden = true
            noBtn.isHidden = true
            alertImageView.isHidden = true
            cancelBtn.isHidden = false
            setupTitleLabel(title: "Confirm Your Appointment")
            
        case .successButton:
            confirmBtn.isHidden = false
            yesBtn.isHidden = true
            noBtn.isHidden = true
            alertImageView.image = UIImage(named: "Right")
            cancelBtn.isHidden = true
            
        case .failButton:
            confirmBtn.isHidden = false
            yesBtn.isHidden = true
            noBtn.isHidden = true
            alertImageView.image = UIImage(named: "Wrong")
            alertImageView.contentMode = .scaleToFill
            cancelBtn.isHidden = true
            
        case .twoButtons:
            confirmBtn.isHidden = true
            yesBtn.isHidden = false
            noBtn.isHidden = false
            noBtn.backgroundColor = UIColor(red: 111.0 / 255.0, green: 4.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
            noBtn.setTitle("No", for: .normal)
            yesBtn.setTitle("Yes", for: .normal)
            alertImageView.isHidden = true
            cancelBtn.isHidden = true
            messageLabel.isHidden = true
        }
    }
    private func setupContainerView(){
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
    }
    
    private func setUpMainView(){
    let blurEffect = UIBlurEffect(style: .light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = self.frame
    self.insertSubview(blurEffectView, at: 0)
    self.backgroundColor = .clear
    self.layer.cornerRadius = 10
    }
    
    private func setupTitleLabel(title: String){
        titleLabel.text = title
        titleLabel.textAlignment = NSTextAlignment.center;
        titleLabel.textColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        titleLabel.font = UIFont(name: "PTSans-Bold" ,size: 15)
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 0
        //titleLabel.lineBreakMode = .byWordWrapping
    }
    
    private func setupMessage(message: String){
        messageLabel.text = message
        messageLabel.textAlignment = NSTextAlignment.center;
        messageLabel.textColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        messageLabel.font = UIFont(name: "PTSans-Regular" ,size: 15)
        messageLabel.sizeToFit()
        messageLabel.numberOfLines = 0
    }
    
    private func setupConfirmMessage(timeStamp: Int, docName: String){
        messageLabel.textAlignment = NSTextAlignment.center;
        messageLabel.textColor = .black
        messageLabel.font = UIFont(name: "PTSans-Regular" ,size: 20)
        messageLabel.sizeToFit()
        messageLabel.numberOfLines = 0
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont(name: "PTSans-Bold", size: 15)!
        ]
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont(name: "PTSans-Regular", size: 15)!
        ]
        let apiDate = Date(timeIntervalSinceNow: TimeInterval(timeStamp))
        let formatterDate = DateFormatter()
        let formatterTime = DateFormatter()
        formatterDate.dateFormat = "EEEE, MMM d, yyyy"
        formatterTime.dateFormat = "h:mm a"
        let boldText = NSAttributedString(string: "\(formatterDate.string(from: apiDate)).\(formatterTime.string(from: apiDate)) with \(docName)", attributes: boldAttribute)
        let regularText = NSAttributedString(string: " You are about to book an appointment on, ", attributes: regularAttribute)
        let newString = NSMutableAttributedString()
        newString.append(regularText)
        newString.append(boldText)
        messageLabel.attributedText = newString
    }
    
    private func setupBtn(btnTitle: String){
        confirmBtn.setTitle(btnTitle, for: .normal)
        confirmBtn.tintColor = .white
        confirmBtn.titleLabel?.font = UIFont(name: "PTSans-Bold" , size: 15)
        noBtn.titleLabel?.font = UIFont(name: "PTSans-Bold" , size: 15)
        yesBtn.titleLabel?.font = UIFont(name: "PTSans-Bold" , size: 15)
    }
}
