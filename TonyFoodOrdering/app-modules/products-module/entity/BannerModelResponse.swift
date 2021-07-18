//
//  BannerModelResponse.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 18/7/21.
//

import UIKit
import ObjectMapper

private let SUCCESS = "success"
private let DATA = "data"

class BannerModelResponse: Mappable {
    
    dynamic var success = ""
    dynamic var data = [BannerModel]()
    
    required init?(map:Map) {
        mapping(map: map)
    }

    func mapping(map:Map) {
        success <- map[SUCCESS]
        data <- map[DATA]
    }
}
