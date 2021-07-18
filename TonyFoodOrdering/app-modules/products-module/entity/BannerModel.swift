//
//  BannerModel.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 18/7/21.
//

import Foundation
import ObjectMapper

private let ID = "id"
private let TITLE = "title"
private let IMAGEURL = "imageUrl"

class BannerModel: Mappable {
    
    dynamic var id = ""
    dynamic var title = ""
    dynamic var imageURL = ""
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map) {
        id <- map[ID]
        title <- map[TITLE]
        imageURL <- map[IMAGEURL]
    }
}
