//
//  UserLoginBodyData.swift
//  IDEA Hospital
//
//  Created by Hossam Yasser on 1/11/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct UserloginBodyData: Codable{
    let email: String?
    let password: String?
    let doctorId: Int?
    let appointment: String?
    let voucher: String?
    let patientName: String?
    let bookForAnother: Bool?
    
    enum CodingKeys: String, CodingKey {
        case email, password, appointment, voucher
        case doctorId = "doctor_id"
        case patientName = "patient_name"
        case bookForAnother = "book_for_another"
    }
}


