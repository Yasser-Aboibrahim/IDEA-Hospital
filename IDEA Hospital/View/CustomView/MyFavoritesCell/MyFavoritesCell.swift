//
//  MyFavoritesCell.swift
//  IDEA Hospital
//
//  Created by yasser on 12/18/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit
import Cosmos

//MARK:- MyFavoritesCell Protocol
protocol MyFavoritesCelllDelegate:class{
    func deleteBtnTapped(_ tag: Int)
    func viewPrfileBtnTapped(_ tag: Int)
}

//MARK:- Extension MyFavoritesCellProtocol
protocol MyFavoritesCellProtocol: class{
    func configure(drImage: UIImage,name: String, Specialist: String, address: String, Specialist2: String, time: Int, fees: Int, rating: Int, reviews: Int)
}

class MyFavoritesCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var drImageView: UIImageView!
    @IBOutlet weak var drNameLabel: UILabel!
    @IBOutlet weak var drRatingCosmos: CosmosView!
    @IBOutlet weak var drSpecialityLabel: UILabel!
    @IBOutlet weak var drSpecialityLabel2: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var feesLabel: UILabel!
    @IBOutlet weak var specialityImageView: UIImageView!
    @IBOutlet weak var addressImageView: UIImageView!
    @IBOutlet weak var timeImageView: UIImageView!
    @IBOutlet weak var feesImageView: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var viewProfileBtn: UIButton!
    
    //MARK:- Properties
    weak var delegate: MyFavoritesCelllDelegate?
    
    // MARK:- Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellView()
        setRatingCosmos()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- Actions
    @IBAction func deleteBtnTapped(_ sender: UIButton) {
        delegate?.deleteBtnTapped(sender.tag)
    }
    
    @IBAction func viewProfileBtnTapped(_ sender: UIButton) {
        delegate?.viewPrfileBtnTapped(sender.tag)
    }
}

//MARK:- Extension Private Methods
extension MyFavoritesCell{
    //MARK:- Private Methods
    private func setCellView(){
        drImageView.layer.cornerRadius =  drImageView.frame.size.width / 2
        drImageView.backgroundColor = .clear
        drImageView.tintColor = .clear
        drImageView.image = UIImage(named: "EmptyDoctorImage")
        drImageView.contentMode = UIView.ContentMode.scaleToFill
        drImageView.layer.borderWidth = 2
        drImageView.layer.borderColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0).cgColor
        drImageView.clipsToBounds = true
        
        specialityImageView.image = UIImage(named: "Speciality")
        addressImageView.image = UIImage(named: "Pin-1")
        timeImageView.image = UIImage(named: "clock")
        feesImageView.image = UIImage(named: "Fees")
        
        drNameLabel.textAlignment = NSTextAlignment.left;
        drNameLabel.textColor = UIColor.white
        drNameLabel.font = UIFont(name: "PTSans-Bold" ,
                                  size: 15)
        
        
        drSpecialityLabel.textAlignment = NSTextAlignment.left;
        drSpecialityLabel.textColor = UIColor.white
        drSpecialityLabel.font = UIFont(name: "PTSans-Bold" ,
                                        size: 15)
        
        drSpecialityLabel2.textAlignment = NSTextAlignment.left;
        drSpecialityLabel2.textColor = UIColor.white
        drSpecialityLabel2.font = UIFont(name: "PTSans-Regular" ,
                                         size: 12)
        
        addressLabel.textAlignment = NSTextAlignment.left;
        addressLabel.textColor = UIColor.white
        addressLabel.font = UIFont(name: "PTSans-Regular" ,
                                   size: 12)
        
        timeLabel.textAlignment = NSTextAlignment.left;
        timeLabel.textColor = UIColor.white
        timeLabel.font = UIFont(name: "PTSans-Regular" ,
                                size: 12)
        
        feesLabel.textAlignment = NSTextAlignment.left;
        feesLabel.textColor = UIColor.white
        feesLabel.font = UIFont(name: "PTSans-Regular" ,
                                size: 12)
        
        deleteBtn.setImage(UIImage(named: "DeleteButton"), for: .normal)
        deleteBtn.tintColor = .white
        viewProfileBtn.setTitle("View Profile", for: .normal)
        viewProfileBtn.titleLabel?.font = UIFont(name: "PTSans-Bold" , size: 12)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.backgroundView = UIView(backgroundColor: .clear)
        self.backgroundView?.addSeparator()
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

//MARK:- Extension MyFavoritesCellProtocol funcs
extension MyFavoritesCell: MyFavoritesCellProtocol{
    func configure(drImage: UIImage, name: String, Specialist: String, address: String, Specialist2: String, time: Int, fees: Int, rating: Int, reviews: Int) {
        drImageView.image = drImage
        drNameLabel.text = name
        drRatingCosmos.text = "\(reviews) Review"
        drRatingCosmos.rating = Double(rating)
        drSpecialityLabel.text = Specialist
        drSpecialityLabel2.text = Specialist2
        feesLabel.text = "Examination fees: \(fees) LE"
        timeLabel.text = "Waiting Time:\(time) Minutes"
        addressLabel.text = address
    }
    
    
}
