//
//  StringExtension.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 15/7/21.
//

import UIKit

extension Optional where Wrapped == String {
    
    var unwrap: String {
        return self ?? ""
    }
}
