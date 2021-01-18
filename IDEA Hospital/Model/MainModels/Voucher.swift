//
//  Voucher.swift
//  IDEA Hospital
//
//  Created by yasser on 12/7/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct Voucher: Codable {
    var id: Int
    var code: Int
    var discountPercent: Float
    var expiredAt: Int
    
    enum CodingKeys: String, CodingKey {
        case id, code
        case discountPercent = "discount_percent"
        case expiredAt = "expired_at"
    }
    
}
