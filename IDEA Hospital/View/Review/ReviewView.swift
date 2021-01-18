//
//  ReviewView.swift
//  IDEA Hospital
//
//  Created by Hossam Yasser on 12/30/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit
import Cosmos

class ReviewView: UIView {
    
    //Mark: outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var drRatingCosmos: CosmosView!
    @IBOutlet weak var addCommentTextField: UITextField!
    @IBOutlet weak var submitReviewButton: CommonBigButton!
    
    func setup() {
        setupLabel()
        setRatingCosmos()
        setUpTextField(addCommentTextField, placeHolder: "Add Comment")
        setButton()
        addBackground()
       
    }
}

extension ReviewView{
    
    private func addBackground(imageName: String = "BackGroundpicture", contentMode: UIView.ContentMode = .scaleToFill) {
        // setup the UIImageView
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = contentMode
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)
        // adding NSLayoutConstraints
        let leadingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
    
    func setupLabel(){
            titleLabel.textAlignment = NSTextAlignment.center;
            titleLabel.textColor = UIColor.white
            titleLabel.font = UIFont(name: "PTSans-Bold" ,
                                      size: 14)
            titleLabel.backgroundColor = .clear
            titleLabel.text = "Please rate your experience with the doctor"

    }

    private func setRatingCosmos(){
        drRatingCosmos.settings.updateOnTouch = true
        
        // Show only fully filled stars
        drRatingCosmos.settings.fillMode = .full
        // Other fill modes: .half, .precise
        
        // Change the size of the stars
        drRatingCosmos.settings.starSize = 15
        
        
        // Set the distance between stars
        drRatingCosmos.settings.starMargin = 3
        
        // Set the color of a filled star
        drRatingCosmos.settings.filledColor = UIColor.orange
        
        // Set the border color of an empty star
        drRatingCosmos.settings.emptyBorderColor = UIColor.orange
        
        // Set the border color of a filled star
        drRatingCosmos.settings.filledBorderColor = UIColor.orange
        
        // Set image for the filled star
        drRatingCosmos.settings.filledImage = UIImage(named: "GoldFilledStar")
        
        // Set image for the empty star
        drRatingCosmos.settings.emptyImage = UIImage(named: "GoldEmptyStar")
        
        self.backgroundColor = .clear
    }
    
    func setUpTextField(_ textField: UITextField, placeHolder: String) {
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "PTSans-Bold", size: 14)!])
        textField.font = UIFont(name: "PTSans-Bold", size: 14)
        textField.textAlignment = NSTextAlignment.left;
         textField.textColor = UIColor.white
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.height + 1 , width: frame.width, height: 2)
       // self.borderStyle = .none
        bottomLine.backgroundColor = UIColor.white.cgColor
        self.layer.addSublayer(bottomLine)
        self.layer.masksToBounds = true
    }
    
    private func setButton() {
        submitReviewButton.setTitle("Submit Button", for: .normal)
        submitReviewButton.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 20)
        submitReviewButton.setTitleColor(.white , for: .normal)
        
    }
}
