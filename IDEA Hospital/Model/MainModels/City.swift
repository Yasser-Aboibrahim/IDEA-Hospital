//
//  City.swift
//  IDEA Hospital
//
//  Created by yasser on 12/7/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct City: Codable {
    var id: Int
    var name: String
    var regions: [Region]
    
    enum CodingKeys: String, CodingKey {
        case id, name, regions
    }
}
