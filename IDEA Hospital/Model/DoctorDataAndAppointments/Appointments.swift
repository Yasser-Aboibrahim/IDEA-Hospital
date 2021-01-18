//
//  Appointments.swift
//  IDEA Hospital
//
//  Created by yasser on 12/19/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct AppointmentsResponse: Codable {
    var data: Appointments
}

struct Appointments: Codable {
    var items: [AppointmentsItems]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct AppointmentsItems: Codable {
    var id: Int
    var appointment: Int
    var bookForAnother: Bool
    var patientName: String
    var doctor: Doctor
    
    enum CodingKeys: String, CodingKey {
        case id, appointment, doctor
        case bookForAnother = "book_for_another"
        case patientName = "patient_name"
    }
}

struct deleteAppointment: Codable{
    var success: Bool
}
