//
//  DocotorAppointmentsResponse.swift
//  IDEA Hospital
//
//  Created by yasser on 12/31/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct DocotorAppointmentsResponse: Codable{
    var data: [DocotorAppointments]
    var code: Int?
}

struct DocotorAppointments: Codable{
    var date: Int
    var times: [DocotorAppointmentsTime]
}

struct DocotorAppointmentsTime: Codable{
    var time: Int
    var booked: Bool

}
