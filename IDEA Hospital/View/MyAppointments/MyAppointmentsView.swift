//
//  MyAppointmentsView.swift
//  IDEA Hospital
//
//  Created by yasser on 12/19/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class MyAppointmentsView: UIView {
    
    // MARK:- Outlets
    @IBOutlet weak var myAppointmentsTableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    // MARK:- Public Method
    func setup(){
        myAppointmentsTableView.backgroundColor = .clear
        noDataLabel.text = ""
        noDataLabel.textAlignment = NSTextAlignment.center;
        noDataLabel.textColor = UIColor.white
        noDataLabel.font = UIFont(name: "PTSans-Bold" , size: 30)
        setAppoTableView()
    }
    
    func createSpinnerFooter()-> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    private func setAppoTableView(){
        myAppointmentsTableView.register(UINib(nibName: Cells.myAppointmentsCell, bundle: nil), forCellReuseIdentifier: Cells.myAppointmentsCell)
        myAppointmentsTableView.tableFooterView = UIView(frame: .zero)
        myAppointmentsTableView.rowHeight = UITableView.automaticDimension
        myAppointmentsTableView.estimatedRowHeight = 217
    }
}
