//
//  DoctorDataByIDResponse.swift
//  IDEA Hospital
//
//  Created by yasser on 12/31/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct DoctorDataByIDResponse: Codable{
    var data: Doctor
    var code: Int?
}
