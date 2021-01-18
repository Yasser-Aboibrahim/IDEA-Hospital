//
//  EditProfileBodyData.swift
//  IDEA Hospital
//
//  Created by yasser on 1/8/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct EditProfileBodyData: Codable{
    let name: String
    let email: String
    let mobile: String
    let password: String?
    let oldPassword: String?
    
    enum CodingKeys: String, CodingKey{
        case name, mobile, password, email
        case oldPassword = "old_password"
    }
    
}
