//
//  DoctorProfileView.swift
//  IDEA Hospital
//
//  Created by yasser on 12/30/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit
import Cosmos

class DoctorProfileView: UIView {

    //MARK:- Outlets
   
    @IBOutlet weak var drImageView: UIImageView!
    @IBOutlet weak var drNameLabel: UILabel!
    @IBOutlet weak var drRatingCosmos: CosmosView!
    @IBOutlet weak var drBioLabel: UILabel!
    @IBOutlet weak var bookDayLabel: UILabel!
    @IBOutlet weak var nextDayBtn: UIButton!
    @IBOutlet weak var backDayBtn: UIButton!
    @IBOutlet weak var tabViewBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var doctorProfileCollectionView: UICollectionView!
    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var doctorProfileBtn: UIButton!
    @IBOutlet weak var doctorReviewsBtn: UIButton!
    @IBOutlet weak var doctorReviewsTopBtnLabel: UILabel!
    @IBOutlet weak var doctorReviewsBottomBtnLabel: UILabel!
    
    @IBOutlet weak var doctorProfileBioLabel: UILabel!
    @IBOutlet weak var doctorProfileBioImageView: UIImageView!
    
    @IBOutlet weak var doctorProfileSecondBilLabel: UILabel!
    @IBOutlet weak var doctorProfileSecondBioImageView: UIImageView!
    
    @IBOutlet weak var doctorProfileAddressLabel: UILabel!
    @IBOutlet weak var doctorProfileAddressImageView: UIImageView!
    
    @IBOutlet weak var doctorProfileViewOnMapImageView: UIImageView!
    @IBOutlet weak var doctorProfileViewOnMapBtn: UIButton!
    
    @IBOutlet weak var doctorProfileWaitingTimeLabel: UILabel!
    @IBOutlet weak var doctorProfileWaitingTimeIcon: UIImageView!
    
    @IBOutlet weak var doctorProfileFeesLabel: UILabel!
    @IBOutlet weak var doctorProfileFeesImageView: UIImageView!
    
    @IBOutlet weak var doctorProfileCompaniesImageView: UIImageView!
    @IBOutlet weak var doctorProfileCompaniesLabel: UILabel!
    
    @IBOutlet weak var noBookTimeLabel: UILabel!
    
    @IBOutlet weak var doctorReviewsTabelView: UITableView!
    
    @IBOutlet weak var doctorProfileScrollView: UIScrollView!
    
    //MARK:- Public Methods
    func setup(){
        setupImageViews()
        setScrollView()
        setupLabels()
        setupBtns()
        setRatingCosmos()
        setupGridView()
        setDrReviewsTableview()
        nextOrBackDayBtnTapped()
        doctorProfileLabels(label: doctorProfileBioLabel)
        doctorProfileLabels(label: doctorProfileSecondBilLabel)
        doctorProfileLabels(label: doctorProfileAddressLabel)
        doctorProfileLabels(label: doctorProfileWaitingTimeLabel)
        doctorProfileLabels(label: doctorProfileFeesLabel)
        doctorProfileLabels(label: doctorProfileCompaniesLabel)
        doctorProfileIcons(imageView: doctorProfileBioImageView, imageName: "DPBio")
        doctorProfileIcons(imageView: doctorProfileSecondBioImageView, imageName: "DPSecondBio")
        doctorProfileIcons(imageView: doctorProfileAddressImageView, imageName: "DPPin")
        doctorProfileIcons(imageView: doctorProfileViewOnMapImageView, imageName: "DPPin2")
        doctorProfileIcons(imageView: doctorProfileWaitingTimeIcon, imageName: "DPClock")
        doctorProfileIcons(imageView: doctorProfileFeesImageView, imageName: "DPMoney3")
        doctorProfileIcons(imageView: doctorProfileCompaniesImageView, imageName: "DPComp")
        
    }
    
    func createSpinnerFooter()-> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func  doctorProfileBtnTapped(){
        doctorReviewsTabelView.isHidden = true
        doctorProfileScrollView.isHidden = false
        doctorReviewsBtn.backgroundColor = .lightGray
        doctorProfileBtn.backgroundColor = .white
        doctorReviewsTabelView.isScrollEnabled = true
    }
    
    func doctorReviewsBtnTapped(){
        doctorReviewsTabelView.isHidden = false
        doctorProfileScrollView.isHidden = true
        doctorReviewsBtn.backgroundColor = .white
        doctorProfileBtn.backgroundColor = .lightGray
    }
    
    func setDoctorData(doctorImage: UIImage, doctorName: String, doctorBio: String, doctorRate: Int, reviews: Int, doctorSecondBio: String, address: String, time: Int, fees: Int, companies: String, speciality: String, isFavorite: Bool){
        drNameLabel.text = doctorName
        drImageView.image = doctorImage
        drBioLabel.text = doctorBio
        drRatingCosmos.rating = Double(doctorRate)
        doctorReviewsBottomBtnLabel.text = "\(reviews) Reviews"
        doctorProfileBioLabel.text = speciality
        doctorProfileSecondBilLabel.text = doctorSecondBio
        doctorProfileAddressLabel.text = address
        doctorProfileWaitingTimeLabel.text = "Waiting Time:\(time) Minutes"
        doctorProfileFeesLabel.text = "Examination fees: \(fees) LE"
        doctorProfileCompaniesLabel.text = companies
        
        if UserDefaultsManager.shared().token != nil{
            if isFavorite {
                favoriteBtn.setImage(UIImage(named: "redHeart"), for: .normal)
                favoriteBtn.tintColor = UIColor.red
            }else{
                favoriteBtn.setImage(UIImage(named: "heart"), for: .normal)
                favoriteBtn.tintColor = UIColor.white
            }
        }else{
            favoriteBtn.setImage(UIImage(named: "heart"), for: .normal)
            favoriteBtn.tintColor = UIColor.white
        }
    }
    
    func favoriteBtnViewAfterPress(){
        if UserDefaultsManager.shared().token != nil{
            if favoriteBtn.tintColor == UIColor.red{
                favoriteBtn.setImage(UIImage(named: "heart"), for: .normal)
                favoriteBtn.tintColor = UIColor.white
            }else{
                favoriteBtn.setImage(UIImage(named: "redHeart"), for: .normal)
                favoriteBtn.tintColor = UIColor.red
            }
        }
    }
    
    func bookButtonSelectionState(){
        if bookBtn.backgroundColor == .gray{
            bookBtn.backgroundColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
            bookBtn.isUserInteractionEnabled = true
        }else{
            bookBtn.backgroundColor = .gray
            bookBtn.isUserInteractionEnabled = false
        }
    }
    
    func nextOrBackDayBtnTapped(){
        bookBtn.backgroundColor = .gray
        bookBtn.isUserInteractionEnabled = false
    }
    
    func bookButtonDeselectionState(){
            bookBtn.backgroundColor = .gray
        bookBtn.isUserInteractionEnabled = false
    }
    
    func bookTimeData(isAvailablel: Bool){
      if isAvailablel{
       noBookTimeLabel.text = ""
      }else{
       noBookTimeLabel.text = "No Appointments to Book"
      }
    }
}

//MARK:-Extension Private Methods
extension DoctorProfileView{
    
    private func setupImageViews(){
        drImageView.layer.cornerRadius =  drImageView.frame.size.width / 2
        drImageView.backgroundColor = .clear
        drImageView.image = UIImage(named: "EmptyDoctorImage")
        drImageView.contentMode = UIView.ContentMode.scaleToFill
        drImageView.layer.borderWidth = 2
        drImageView.layer.borderColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0).cgColor
        doctorProfileBioImageView.image = UIImage(named: "DPBio")
    }
    
    private func setScrollView(){
    doctorProfileScrollView.backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1.0)
    doctorProfileScrollView.isHidden = false
    }
    
    private func setupLabels(){
        drNameLabel.textAlignment = NSTextAlignment.left;
        drNameLabel.textColor = UIColor.white
        drNameLabel.font = UIFont(name: "PTSans-Bold" , size: 15)
        
        noBookTimeLabel.textAlignment = NSTextAlignment.center
        noBookTimeLabel.textColor = UIColor.white
        noBookTimeLabel.font = UIFont(name: "PTSans-Bold" , size: 20)
        noBookTimeLabel.text = ""
        
        drBioLabel.textAlignment = NSTextAlignment.left;
        drBioLabel.textColor = UIColor.white
        drBioLabel.font = UIFont(name: "PTSans-Regular" , size: 12)
        
        bookDayLabel.textAlignment = NSTextAlignment.center;
        bookDayLabel.textColor = UIColor.white
        bookDayLabel.backgroundColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        bookDayLabel.font = UIFont(name: "PTSans-Bold" , size: 12)
        
        doctorReviewsTopBtnLabel.textAlignment = NSTextAlignment.center;
        doctorReviewsTopBtnLabel.textColor = UIColor.black
        doctorReviewsTopBtnLabel.backgroundColor = .clear
        doctorReviewsTopBtnLabel.font = UIFont(name: "PTSans-Bold" , size: 15)
        doctorReviewsTopBtnLabel.text = "Reviews"
        
        doctorReviewsBottomBtnLabel.textAlignment = NSTextAlignment.center;
        doctorReviewsBottomBtnLabel.textColor = UIColor(red: 111.0 / 255.0, green: 4.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
        doctorReviewsBottomBtnLabel.backgroundColor = .clear
        doctorReviewsBottomBtnLabel.font = UIFont(name: "PTSans-Regular" , size: 13)
    }
    
    private func setupBtns(){
        favoriteBtn.setImage(UIImage(named: "heart"), for: .normal)
        
        nextDayBtn.setImage(UIImage(named: "nextArrow"), for: .normal)
        nextDayBtn.tintColor = .white
        
        backDayBtn.setImage(UIImage(named: "backArrow"), for: .normal)
        backDayBtn.tintColor = .white
        bookBtn.backgroundColor = .gray
        
        bookBtn.setTitle("Book Now", for: .normal)
        bookBtn.setTitleColor(.white, for: .normal)
        
        doctorProfileBtn.backgroundColor =  .white
        doctorProfileBtn.setTitle("Doctor Profile", for: .normal)
        doctorProfileBtn.setTitleColor(.black, for: .normal)
        doctorProfileBtn.roundCorners(with: [.layerMinXMinYCorner], radius: 20)
        doctorProfileBtn.adjustsImageWhenHighlighted = false
        doctorProfileBtn.tintAdjustmentMode = .normal
        
        doctorReviewsBtn.backgroundColor =  .lightGray
        doctorReviewsBtn.roundCorners(with: [.layerMaxXMinYCorner], radius: 20)
        
        doctorProfileViewOnMapBtn.setTitleColor(UIColor(red: 111.0 / 255.0, green: 4.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0), for: .normal)
    }
    
    private func setRatingCosmos(){
        drRatingCosmos.settings.updateOnTouch = false
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
    
    private func setupGridView(){
        doctorProfileCollectionView.register(doctorProfileCollectionViewCell.nib(), forCellWithReuseIdentifier: Cells.DoctorProfileCollectionViewCell)
        let flow = doctorProfileCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.scrollDirection = .horizontal
        doctorProfileCollectionView.setCollectionViewLayout(flow, animated: true)
        doctorProfileCollectionView.backgroundColor = .clear
        doctorProfileCollectionView.allowsMultipleSelection = false
    }
    
    private func doctorProfileLabels(label: UILabel){
        label.textAlignment = NSTextAlignment.left;
        label.textColor = UIColor.black
        label.font = UIFont(name: "PTSans-Regular" , size: 12)
    }
    
    private func doctorProfileIcons(imageView: UIImageView, imageName: String){
        imageView.image = UIImage(named: imageName)
        imageView.backgroundColor = .clear
        imageView.contentMode = UIView.ContentMode.scaleToFill
    }
    
    private func setDrReviewsTableview(){
        doctorReviewsTabelView.register(UINib(nibName: Cells.doctorReviewsTabelViewCell, bundle: nil), forCellReuseIdentifier: Cells.doctorReviewsTabelViewCell)
        doctorReviewsTabelView.tableFooterView = UIView(frame: .zero)
        doctorReviewsTabelView.rowHeight = UITableView.automaticDimension
        doctorReviewsTabelView.estimatedRowHeight = 78
        doctorReviewsTabelView.backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1.0)
        doctorReviewsTabelView.isHidden = true
    }
}

