//
//  TermsAndConditions.swift
//  IDEA Hospital
//
//  Created by yasser on 12/25/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct TermsAndConditionsResponse: Codable{
    var data: TermsAndConditions
}

struct TermsAndConditions: Codable{
    var termsAndConditions : String
    enum CodingKeys: String, CodingKey {
        case termsAndConditions = "terms_and_conditions"
    }
}

