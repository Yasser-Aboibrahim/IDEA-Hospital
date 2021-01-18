//
//  UserDoctorAppointment.swift
//  IDEA Hospital
//
//  Created by yasser on 12/7/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct UserDoctorAppointment: Codable {
    var doctorId: Int
    var appointment: String //($date)
    var bookForAnother: Bool
    var patientName: String?
    // var doctor: [Doctor]
    var voucher: String?
    
    
    enum CodingKeys: String, CodingKey {
        case appointment, voucher
        case bookForAnother = "book_for_another"
        case patientName = "patient_name"
        case doctorId = "doctor_id"
    }
}

struct UserDoctorAppointmentResponse: Codable{
    let success: Bool?
    let message: String?
    let code: Int?
    let errors: AuthError?
    
}
