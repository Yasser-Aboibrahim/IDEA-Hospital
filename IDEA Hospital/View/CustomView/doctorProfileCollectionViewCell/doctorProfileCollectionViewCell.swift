//
//  doctorProfileCollectionViewCell.swift
//  IDEA Hospital
//
//  Created by yasser on 12/31/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

//MARK:- doctorProfileCollectionViewCell Protocol
protocol DoctorProfileCollectionViewCellProtocol: class{
    func cellCongigure(time: Int, isBooked: Bool)
}

class doctorProfileCollectionViewCell: UICollectionViewCell {

    //MARK:- Outlets
    @IBOutlet weak var timeLabel: UILabel!
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setLabel()
        setCell()
    }
    
    // cell register
    static func nib() -> UINib {
        return UINib(nibName: Cells.DoctorProfileCollectionViewCell, bundle: nil)
    }
    
    // Public Methods
    func selectTimeLabel(){
        if timeLabel.backgroundColor == UIColor(red: 15.0 / 255.0, green: 133.0 / 255.0, blue: 185.0 / 255.0, alpha: 1.0){
           timeLabel.backgroundColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
            return
        }
        timeLabel.backgroundColor = UIColor(red: 15.0 / 255.0, green: 133.0 / 255.0, blue: 185.0 / 255.0, alpha: 1.0)
    }
    
    func deSelectTimeLabel(){
        timeLabel.backgroundColor = UIColor(red: 15.0 / 255.0, green: 133.0 / 255.0, blue: 185.0 / 255.0, alpha: 1.0)
    }
    
} 

//MARK:- Extension Private Methods
extension doctorProfileCollectionViewCell{
    private func setLabel(){
        timeLabel.backgroundColor =  UIColor(red: 15.0 / 255.0, green: 133.0 / 255.0, blue: 185.0 / 255.0, alpha: 1.0)
        timeLabel.textAlignment = NSTextAlignment.center;
        timeLabel.textColor = UIColor.white
        timeLabel.font = UIFont(name: "PTSans-Bold" , size: 12)
    }
    
    private func setCell(){
        self.layer.cornerRadius = self.frame.size.width / 10
        self.backgroundColor = UIColor(red: 15.0 / 255.0, green: 133.0 / 255.0, blue: 185.0 / 255.0, alpha: 1.0)
    }
    
}

//MARK:- Extension doctorProfileCollectionViewCell Protocol Funcs
extension doctorProfileCollectionViewCell: DoctorProfileCollectionViewCellProtocol{
    func cellCongigure(time: Int, isBooked: Bool) {
        let apiDate = Date(timeIntervalSinceNow: TimeInterval(time))
        let formatterTime = DateFormatter()
        formatterTime.dateFormat = "h:mm a"
        timeLabel.text = "\(formatterTime.string(from: apiDate))"
        
        if isBooked {
            self.isUserInteractionEnabled = false
            timeLabel.backgroundColor = .gray
        }else{
            timeLabel.backgroundColor = UIColor(red: 15.0 / 255.0, green: 133.0 / 255.0, blue: 185.0 / 255.0, alpha: 1.0)
        }
    }
}

