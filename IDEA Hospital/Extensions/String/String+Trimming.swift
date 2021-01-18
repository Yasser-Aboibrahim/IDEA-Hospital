//
//  String+Trimming.swift
//  IDEA Hospital
//
//  Created by yasser on 12/7/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

extension String {
    var trimmed: String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
