//
//  DoctorReviewsResponse.swift
//  IDEA Hospital
//
//  Created by yasser on 1/2/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct DocotorReviewsResponse: Codable{
    var data: DocotorReviewsItems
}

struct DocotorReviewsItems: Codable{
    var items: [DocotorReviews]
    var page: Int
    var perPage: Int
    
    enum CodingKeys: String, CodingKey {
        case  items, page
        case perPage = "per_page"
    }
}

struct DocotorReviews: Codable{
    var rating: Int
    var comment: String
    var commentedBy: String
    
    enum CodingKeys: String, CodingKey {
        case  rating, comment
        case commentedBy = "commented_by"
    }
    
}
