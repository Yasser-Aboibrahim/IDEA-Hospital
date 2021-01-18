//
//  EditProfileUserData.swift
//  IDEA Hospital
//
//  Created by yasser on 1/16/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct UserDataResponse: Codable {
    var data: UserDataEditProfile
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
}

struct UserDataEditProfile: Codable {
    var email: String
    var name: String
    var mobile: String
    
    enum CodingKeys: String, CodingKey {
        case email, name, mobile
    }
    
}
