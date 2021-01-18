//
//  AuthResponse.swift
//  IDEA Hospital
//
//  Created by yasser on 12/29/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct AuthResponse: Codable{
    let data: AuthData?
    let code: Int
    let success: Bool?
    let errors: AuthError?
    let message: String?
}

struct AuthError: Codable{
    let email: [String]?
    let voucher: [String]?
}

struct AuthData: Codable{
    let id: Int?
    let email: String?
    let name: String?
    let mobile: String?
    let accessToken: String?
    enum CodingKeys: String, CodingKey {
        case  id, name, email, mobile
        case accessToken = "access_token"
    }
}
