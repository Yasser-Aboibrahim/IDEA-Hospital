//
//  AboutUs.swift
//  IDEA Hospital
//
//  Created by yasser on 12/25/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct AboutUsResponse: Codable{
    var data: AboutUs
}

struct AboutUs: Codable{
    var aboutUs : String
    enum CodingKeys: String, CodingKey {
        case aboutUs = "about_us"
    }
}
