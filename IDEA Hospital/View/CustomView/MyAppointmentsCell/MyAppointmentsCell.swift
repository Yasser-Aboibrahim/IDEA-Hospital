//
//  MyAppointmentsCell.swift
//  IDEA Hospital
//
//  Created by yasser on 12/18/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit
import Cosmos

//MARK:- MyAppointmentsCell Protocol
protocol MyAppointmentsCellDelegate:class{
    func deleteBtnTapped(_ tag: Int)
    func locationBtnTapped(_ tag: Int)
}

//MARK:- MyAppointmentsCell Protocol
protocol MyAppointmentsCellProtocol: class{
    func cellConfigure(image: UIImage, name: String, bio: String, time: Int, rating: Int, reviews: Int, date: Int)
}

class MyAppointmentsCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var drImageView: UIImageView!
    @IBOutlet weak var drNameLabel: UILabel!
    @IBOutlet weak var drBioLabel: UILabel!
    @IBOutlet weak var drAddressLabel: UILabel!
    @IBOutlet weak var drTimeLabel: UILabel!
    @IBOutlet weak var drDateLabel: UILabel!
    @IBOutlet weak var drRatingCosmos: CosmosView!
    @IBOutlet weak var addressPinImage: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var locationBtn: UIButton!
    
    //MARK:- Properties
    weak var delegate: MyAppointmentsCellDelegate?
    
    // MARK:- Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellView()
        setRatingCosmos()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteBtnTapped(_ sender: UIButton) {
        delegate?.deleteBtnTapped(sender.tag)
    }
    
    
    @IBAction func locationBtnTapped(_ sender: UIButton) {
        delegate?.locationBtnTapped(sender.tag)
    }
}

//MARK:- Extension MyAppointmentsCellProtocol func
extension MyAppointmentsCell: MyAppointmentsCellProtocol{
    func cellConfigure(image: UIImage, name: String, bio: String, time: Int, rating: Int, reviews: Int, date: Int) {
        drImageView.image = image
        drNameLabel.text = name
        drBioLabel.text = bio
        let apiDate = Date(timeIntervalSinceNow: TimeInterval(date))
        let formatterDate = DateFormatter()
        let formatterTime = DateFormatter()
        formatterDate.dateFormat = "EEEE, MMM d, yyyy"
        formatterTime.dateFormat = "h:mm a"
        drTimeLabel.text = "\(formatterDate.string(from: apiDate))"
        drRatingCosmos.text = "\(reviews) Reviews"
        drRatingCosmos.rating = Double(rating)
        drDateLabel.text = "\(formatterTime.string(from: apiDate))"
    }
}

//MARK:- Extension Private Methods
extension MyAppointmentsCell{
    //MARK:- Private Methods
    private func setCellView(){
        drImageView.layer.cornerRadius =  drImageView.frame.size.width / 2
        drImageView.backgroundColor = .clear
        drImageView.image = UIImage(named: "EmptyDoctorImage")
        drImageView.contentMode = UIView.ContentMode.scaleToFill
        drImageView.layer.borderWidth = 2
        drImageView.layer.borderColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0).cgColor
        //drImageView.clipsToBounds = true
        
        addressPinImage.image = UIImage(named: "Pin-1")
        
        drNameLabel.textAlignment = NSTextAlignment.left;
        drNameLabel.textColor = UIColor.white
        drNameLabel.font = UIFont(name: "PTSans-Bold" ,
                                  size: 15)
        
        
        drBioLabel.textAlignment = NSTextAlignment.left;
        drBioLabel.textColor = UIColor.white
        drBioLabel.font = UIFont(name: "PTSans-Regular" ,
                                         size: 10)
        
        drAddressLabel.textAlignment = NSTextAlignment.left;
        drAddressLabel.textColor = UIColor.white
        drAddressLabel.font = UIFont(name: "PTSans-Regular" ,
                                   size: 13)
        drAddressLabel.text = "View On Map"
        
        drTimeLabel.textAlignment = NSTextAlignment.left;
        drTimeLabel.textColor = UIColor.white
        drTimeLabel.font = UIFont(name: "PTSans-Regular" ,
                                size: 13)
        
        drDateLabel.textAlignment = NSTextAlignment.left;
        drDateLabel.textColor = UIColor.white
        drDateLabel.font = UIFont(name: "PTSans-Regular" ,
                                size: 13)
        
        deleteBtn.setImage(UIImage(named: "DeleteButton"), for: .normal)
        deleteBtn.tintColor = .white
        
        self.selectionStyle = .none
        self.backgroundView = UIView(backgroundColor: .clear)
        self.backgroundView?.addSeparator()
        self.backgroundColor = .clear
    }
    
    private func setRatingCosmos(){
        drRatingCosmos.settings.updateOnTouch = false
        
        // Show only fully filled stars
        //drRatingCosmos.settings.fillMode = .full
        // Other fill modes: .half, .precise
        
        // Change the size of the stars
        drRatingCosmos.settings.starSize = 20
        
        // Set the distance between stars
        drRatingCosmos.settings.starMargin = 2
        
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
    }
}
