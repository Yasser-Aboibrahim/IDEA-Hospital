//
//  Review.swift
//  IDEA Hospital
//
//  Created by yasser on 12/7/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct Review: Codable {
    var rating: Int
    var comment: String
    
    
    enum CodingKeys: String, CodingKey {
        case  rating, comment
        
    }
}

struct ReviewResponse: Codable{
    let message: String?
    let code: Int?
    let success: Bool?
    //  let errors: String?
}


