//
//  TableViewCell.swift
//  IDEA Hospital
//
//  Created by Hossam on 12/18/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit
import Cosmos

//MARK:- TableViewCell Delegate
protocol TableViewCellDelegate: class{
    func bookNowButtonTapped(index: Int)
    func favoriteButtonTapped(index: Int)
}
//MARK:- TableViewCell Protocol
protocol TableViewCellProtocol{
    func cellConfigre(image: UIImage , name: String , rating: Int , reviews: Int , bio: String, specialist: String, address: String , time: Int , fees: Int , isFavorited: Bool)
}

class TableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var drImageView: UIImageView!
    @IBOutlet weak var drNameLAbel: UILabel!
    @IBOutlet weak var drRatingCosmos: CosmosView!
    @IBOutlet weak var drSpecialityLabel: UILabel!
    @IBOutlet weak var drSpecialitySecondLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var feesLabel: UILabel!
    @IBOutlet weak var specialityIcon: UIImageView!
    @IBOutlet weak var addressIcin: UIImageView!
    @IBOutlet weak var timeIcon: UIImageView!
    @IBOutlet weak var feesIcon: UIImageView!
    @IBOutlet weak var bookNowButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    
    //MARK:- Properties
    weak var delegate: TableViewCellDelegate?
    
    // MARK:- Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellView()
        setRatingCosmos()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- Actions
    @IBAction func bookNowButtonTapped(_ sender: UIButton) {
        delegate?.bookNowButtonTapped(index: sender.tag)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        if UserDefaultsManager.shared().token != nil{
            if sender.tintColor == UIColor.red{
                sender.setImage(UIImage(named: "heart"), for: .normal)
                sender.tintColor = UIColor.white
            }else{
                sender.setImage(UIImage(named: "redHeart"), for: .normal)
                sender.tintColor = UIColor.red
            }
        }
        
        delegate?.favoriteButtonTapped(index: sender.tag)
    }
}

//MARK:- Extension Private Methods
extension TableViewCell {
        //MARK:- Private Methods
        private func setCellView(){
            drImageView.layer.cornerRadius =  drImageView.frame.size.width / 2
            drImageView.backgroundColor = .blue
            drImageView.tintColor = .blue
            drImageView.image = UIImage(named: "EmptyDoctorImage")
            drImageView.contentMode = UIView.ContentMode.scaleToFill
            drImageView.layer.borderWidth = 2
            drImageView.layer.borderColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0).cgColor
            drImageView.clipsToBounds = true
            
            drNameLAbel.textAlignment = NSTextAlignment.left;
            drNameLAbel.textColor = UIColor.white
            drNameLAbel.font = UIFont(name: "PTSans-Bold" ,
                                      size: 15)
            
            drSpecialityLabel.textAlignment = NSTextAlignment.left;
            drSpecialityLabel.textColor = UIColor.white
            drSpecialityLabel.font = UIFont(name: "PTSans-Bold" ,
                                            size: 15)
            
            drSpecialitySecondLabel.textAlignment = NSTextAlignment.left;
            drSpecialitySecondLabel.textColor = UIColor.white
            drSpecialitySecondLabel.font = UIFont(name: "PTSans-Regular" ,
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
            
            favouriteButton.setImage(UIImage(named: "favourite"), for: .normal)
            
            
            bookNowButton.setTitle("Book Now", for: .normal)
            bookNowButton.titleLabel?.font = UIFont(name: "PTSans-Bold" ,
                                                     size: 12)
            bookNowButton.setTitleColor(.white , for: .normal)
            bookNowButton.layer.cornerRadius = 10
            bookNowButton.backgroundColor = UIColor.init(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        
            
            self.backgroundColor = UIColor.clear
            self.backgroundView = nil
            self.backgroundView = UIView(backgroundColor: .clear)
            self.backgroundView?.addSeparator()
            self.selectionStyle = .none
        }
        
        private func setRatingCosmos(){
            drRatingCosmos.settings.updateOnTouch = false
            
            // Show only fully filled stars
            //drRatingCosmos.settings.fillMode = .full
            // Other fill modes: .half, .precise
            
            // Change the size of the stars
            drRatingCosmos.settings.starSize = 15
            
            
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
            
            self.backgroundColor = .clear
        }
    }

//MARK:- Extension TableViewCell Protocol
extension TableViewCell : TableViewCellProtocol{
    func cellConfigre(image: UIImage, name: String, rating: Int, reviews: Int, bio: String, specialist: String, address: String, time: Int, fees: Int, isFavorited: Bool) {
        drImageView.image = image
        drNameLAbel.text = name
        drSpecialityLabel.text = specialist
        drSpecialitySecondLabel.text = bio
        addressLabel.text = address
        timeLabel.text = "Waiting Time: \(time) minutes"
        drRatingCosmos.text = "\(reviews) Review"
        drRatingCosmos.rating = Double(rating)
        feesLabel.text = "Examinition Fees: \(fees) LE"
        
        
        if UserDefaultsManager.shared().token != nil{
            if isFavorited {
                favouriteButton.setImage(UIImage(named: "redHeart"), for: .normal)
                favouriteButton.tintColor = UIColor.red
            }else{
                favouriteButton.setImage(UIImage(named: "heart"), for: .normal)
                favouriteButton.tintColor = UIColor.white
            }
        }else{
            favouriteButton.setImage(UIImage(named: "heart"), for: .normal)
            favouriteButton.tintColor = UIColor.white
        }
    }
}
