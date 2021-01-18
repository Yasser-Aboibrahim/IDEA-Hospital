//
//  Doctor.swift
//  IDEA Hospital
//
//  Created by yasser on 12/7/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct Doctor: Codable {
    var id: Int?
    var city: String?
    var bio: String?
    var fees: Int?
    var companies: [String]?
    var secondBio: String?
    var rating: Int?
    var reviewsCount: Int?
    var waitingTime: Int?
    var isFavorited: Bool?
    var lng: Float?
    var specialty: String?
    var address: String?
    var region: String?
    var image: String?
    var lat: Float?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, city, bio, fees, companies, rating, lng
        case specialty, address, region, image, lat, name
        case secondBio = "second_bio"
        case reviewsCount = "reviews_count"
        case waitingTime = "waiting_time"
        case isFavorited = "is_favorited"
    }

}
