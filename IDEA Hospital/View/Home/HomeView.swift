//
//  HomeView.swift
//  IDEA Hospital
//
//  Created by yasser on 12/9/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit



class HomeView: UIView {
    
    // MARK:- Outlets
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- Public Method
    func setup(){
        setupLogo(logoImage: logoImage)
        setupGridView()
    }
}

// MARK:- Private Method
extension HomeView {
    private func setupLogo(logoImage: UIImageView){
        logoImage.image = UIImage(named: "Logo")
        logoImage.contentMode = .scaleToFill
    }
}

// MARK:- Extension collectionView Setup & registration func
extension HomeView{
    private func setupGridView(){
        collectionView.register(HomeCell.nib(), forCellWithReuseIdentifier: Cells.homeCell)
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(16.0)
        flow.minimumLineSpacing = CGFloat(16.0)
    }
}
