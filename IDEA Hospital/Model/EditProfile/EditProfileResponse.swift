//
//  EditProfileResponse.swift
//  IDEA Hospital
//
//  Created by yasser on 1/8/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct EditProfileResponse: Codable{
    let success: Bool?
    let data: EditProfileDataModel
    let code: Int?
    
    enum CodingKeys: String, CodingKey{
        case success, data, code
    }
}

struct EditProfileDataModel: Codable{
    let email: String
    let name: String
    let mobile: String
    let id: Int
    
    enum CodingKeys: String, CodingKey{
        case name, mobile, email, id
    }
    
}
