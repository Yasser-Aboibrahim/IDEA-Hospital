//
//  User.swift
//  IDEA Hospital
//
//  Created by yasser on 12/7/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation


struct User: Codable {
    var email: String
    var name: String
    var mobile: String
    var accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case email, name, mobile
        case accessToken = "access_token"
    }

}
