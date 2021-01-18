//
//  Favorites.swift
//  IDEA Hospital
//
//  Created by yasser on 12/18/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

struct FavoritesResponse: Codable{
    var data: Favorites
}

struct Favorites: Codable{
    var page: Int
    var perPage: Int
    var totalPages: Int
    var items: [Doctor]
    
    enum CodingKeys: String, CodingKey {
        case page, items
        case perPage = "per_page"
        case totalPages = "total_pages"
    }
}

struct addAndRemoveResponse:Codable {
    var success: Bool
    var code: Int?
}
