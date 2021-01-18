//
//  RequestBodyData.swift
//  IDEA Hospital
//
//  Created by yasser on 12/24/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct RequestBodyData: Codable{
    let name: String
    let email: String
    let mobile: String
    let message: String
    enum CodingKeys: String, CodingKey{
        case name, mobile, message, email
    }
    
}
