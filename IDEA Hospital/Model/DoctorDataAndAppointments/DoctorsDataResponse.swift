//
//  DoctorsDataResponse.swift
//  IDEA Hospital
//
//  Created by yasser on 12/24/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct DoctorDataWithFilterItemsResponse: Codable{
    var data : DoctorDataWithFilterItems
}

struct DoctorDataWithFilterItems: Codable{
    var items: [Doctor]
}
