//
//  CategoryData.swift
//  IDEA_Hospital_Team4
//
//  Created by Hossam on 12/7/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

struct CategoryDataResponse: Codable{
    var data: categoryDataResponse
    }

struct categoryDataResponse: Codable{
    let specialties: [Specialist]
    let cities: [City]
    let companies: [Company]
}

struct categoryDataBodyRequest: Codable{
    let page: Int
    let perPage: Int
    let mainCategoryId: Int?
    let specialtyId: Int?
    let cityId: Int?
    let regionId: Int?
    let companyId: Int?
    let orderBy: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case page, name
        case perPage = "per_page"
        case mainCategoryId = "main_category_id"
        case specialtyId = "specialty_id"
        case cityId = "city_id"
        case regionId = "region_id"
        case companyId = "company_id"
        case orderBy = "order_by"
    }
}



