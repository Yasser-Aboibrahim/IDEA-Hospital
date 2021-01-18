//
//  DoctorReviewsTabelViewCell.swift
//  IDEA Hospital
//
//  Created by yasser on 1/1/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import UIKit
import Cosmos

//MARK:- DoctorReviewsTabelViewCell Protocol
protocol DoctorReviewsTabelViewCellProtocol: class{
    func cellConfigure(name: String, comment: String, rating: Int)
}

class DoctorReviewsTabelViewCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var reviewerName: UILabel!
    @IBOutlet weak var reviewerComment: UILabel!
    @IBOutlet weak var reviewerRating: CosmosView!
    
    //MARK:- Life Cycle
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
}

//MARK:- Extension Private Methods
extension DoctorReviewsTabelViewCell{
    //MARK:- Private Methods
    private func setCellView(){
        reviewerName.textAlignment = NSTextAlignment.left;
        reviewerName.textColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
        reviewerName.font = UIFont(name: "PTSans-Bold" ,
                                  size: 12)
     
        reviewerComment.textAlignment = NSTextAlignment.left;
        reviewerComment.textColor = UIColor.black
        reviewerComment.font = UIFont(name: "PTSans-Regular" ,
                                 size: 10)
        
        self.selectionStyle = .none
        self.backgroundView = UIView(backgroundColor: .clear)
        self.backgroundView?.addSeparator()
        self.backgroundColor = .clear
    }
    
    private func setRatingCosmos(){
        
        reviewerRating.settings.updateOnTouch = false
        
        // Show only fully filled stars
        //drRatingCosmos.settings.fillMode = .full
        // Other fill modes: .half, .precise
        
        // Change the size of the stars
        reviewerRating.settings.starSize = 20
        
        // Set the distance between stars
        reviewerRating.settings.starMargin = 2
        
        // Set the color of a filled star
        reviewerRating.settings.filledColor = UIColor.orange
        
        // Set the border color of an empty star
        reviewerRating.settings.emptyBorderColor = UIColor.orange
        
        // Set the border color of a filled star
        reviewerRating.settings.filledBorderColor = UIColor.orange
        
        // Set image for the filled star
        reviewerRating.settings.filledImage = UIImage(named: "GoldFilledStar")
        
        // Set image for the empty star
        reviewerRating.settings.emptyImage = UIImage(named: "GoldEmptyStar")
    }
}

//MARK:- Extension DoctorReviewsTabelViewCell Protocol Funcs
extension DoctorReviewsTabelViewCell: DoctorReviewsTabelViewCellProtocol{
    func cellConfigure(name: String, comment: String, rating: Int) {
        reviewerName.text = name
        reviewerComment.text = comment
        reviewerRating.rating = Double(rating)
    }
}
