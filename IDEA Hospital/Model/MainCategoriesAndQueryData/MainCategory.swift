//
//  MainCategory.swift
//  IDEA Hospital
//
//  Created by yasser on 12/7/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct MainCategoryResponse: Codable {
    var data: [MainCategory]
    
}

struct MainCategory: Codable {
    var id: Int
    var name: String
    var image: String
    var color: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, color
    }
}
