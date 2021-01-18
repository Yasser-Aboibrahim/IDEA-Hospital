//
//  HomeCell.swift
//  IDEA Hospital
//
//  Created by yasser on 12/10/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit
import SDWebImage

// MARK:- HomeCellProtocol
protocol HomeCellProtocol: class{
    func cellCofiguration(name: String, image: UIImage?, color: String)
}

class HomeCell: UICollectionViewCell {
 
    // MARK:- Outlets
    @IBOutlet weak var categoryBackground: UIImageView!
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
   
    // cell register
    static func nib() -> UINib {
        return UINib(nibName: Cells.homeCell, bundle: nil)
    }
}

// MARK:- HomeCell Protocol func
extension HomeCell: HomeCellProtocol{
    // Cell configure
    func cellCofiguration(name: String, image: UIImage?, color: String) {
        categoryBackground.backgroundColor = UIColor(hexString: color)
        categoryIcon.image = image
        categoryName.text = name
        layer.cornerRadius = frame.size.width / 20
    }
}
