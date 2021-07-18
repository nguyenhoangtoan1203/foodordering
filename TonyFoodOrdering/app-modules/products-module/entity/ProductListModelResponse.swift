//
//  ProductListModelResponse.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 18/7/21.
//

import UIKit
import ObjectMapper

private let SUCCESS = "success"
private let DATA = "data"

class ProductListModelResponse: Mappable {
    
    dynamic var success = ""
    dynamic var data = [ProductListModel]()
    
    required init?(map:Map) {
        mapping(map: map)
    }

    func mapping(map:Map) {
        success <- map[SUCCESS]
        data <- map[DATA]
    }
}
