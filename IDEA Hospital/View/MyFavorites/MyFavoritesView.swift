//
//  MyFavoritesView.swift
//  IDEA Hospital
//
//  Created by yasser on 12/18/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class MyFavoritesView: UIView {
    
    // MARK:- Outlets
    @IBOutlet weak var myFavoritesTableView: UITableView!
    @IBOutlet weak var noFavoritesData: UILabel!
    
    // MARK:- Public Method
    func setup(){
        setNoFoundDataLabel()
        setMyFavTableview()
    }
    
    func createSpinnerFooter()-> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    //MARK:- Private Methods
    private func setNoFoundDataLabel(){
        myFavoritesTableView.backgroundColor = .clear
        noFavoritesData.text = ""
        noFavoritesData.textAlignment = NSTextAlignment.center;
        noFavoritesData.textColor = UIColor.white
        noFavoritesData.font = UIFont(name: "PTSans-Bold" ,
                                      size: 30)
    }
    
    private func setMyFavTableview(){
        myFavoritesTableView.register(UINib(nibName: Cells.myFavoritesCell, bundle: nil), forCellReuseIdentifier: Cells.myFavoritesCell)
        myFavoritesTableView.tableFooterView = UIView(frame: .zero)
        myFavoritesTableView.rowHeight = UITableView.automaticDimension
        myFavoritesTableView.estimatedRowHeight = 217
    }
}

