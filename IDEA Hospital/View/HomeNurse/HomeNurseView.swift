//
//  HomeNurseView.swift
//  IDEA Hospital
//
//  Created by Hossam on 12/18/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class HomeNurseView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var EmailTextField: CustomTextField!
    @IBOutlet weak var mobileNumberTextField: CustomTextField!
    @IBOutlet weak var contactUsTitleLabel: UILabel!
    @IBOutlet weak var enterDetailsTextView: UITextView!
    @IBOutlet weak var sendRequestButton: UIButton!
    
    func setup(screenType: ScreenType) {
        setTitleLabel()
        nameTextField.addLineView(leftImage: UIImage(named: "UserIcon")!, placeholder: "Your Name")
        EmailTextField.addLineView(leftImage: UIImage(named: "EmailIcon")!, placeholder: "Your Email")
        mobileNumberTextField.addLineView(leftImage:UIImage(named: "Image")! , placeholder: "Mobile Number")
        detailsTextView(enterDetailsTextView)
        setUpButton()
        setSecondContactUsTitle(screenType: screenType)
    }
}

//MARK:- Private Method
extension HomeNurseView {
    private func setSecondContactUsTitle(screenType: ScreenType){
        switch screenType{
        case .contactUs:
            setContactUsTitleLabel()
        default:
            return
            
        }
    }
    
    private func setUpButton(){
        sendRequestButton.backgroundColor = UIColor.init(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        sendRequestButton.layer.cornerRadius = 10
        sendRequestButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 20)
        sendRequestButton.setTitle("Send Request", for: .normal)
        sendRequestButton.setTitleColor(.white , for: .normal)
        
    }
    
    private func setTitleLabel(){
         titleLabel.numberOfLines = 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        titleLabel.text = "If you would like further information about how we can help you and your health it would be great to hear from you"
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = NSTextAlignment.center;
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "PTSans-Regular" ,size: 12)
        titleLabel.lineBreakMode = .byWordWrapping
    }
    
    private func setContactUsTitleLabel(){
        contactUsTitleLabel.numberOfLines = 1
        contactUsTitleLabel.text = "For More information call: 19199"
        contactUsTitleLabel.adjustsFontSizeToFitWidth = true
        contactUsTitleLabel.textAlignment = NSTextAlignment.center;
        contactUsTitleLabel.textColor = UIColor.white
        contactUsTitleLabel.font = UIFont(name: "PTSans-Regular" ,size: 12)
        contactUsTitleLabel.lineBreakMode = .byWordWrapping
    }
    
    private func detailsTextView(_ textView: UITextView) {
        textView.text = "Enter Details"
        textView.textColor = UIColor.white
        textView.font = UIFont(name: "PTSans-Bold", size: 15)
        textView.layer.cornerRadius = 15
        textView.backgroundColor = .clear
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.white.cgColor
        textView.contentInset = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
    }
    
    private func setUpTextField(textField: CustomTextField , placeHolder: String){
       textField.font = UIFont(name: "PTSans-Bold", size: 15)
        textField.textColor = UIColor.white
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "PTSans-Bold", size: 15)!])
       textField.setLeftPaddingPoints(50)
       
       }
    
}
