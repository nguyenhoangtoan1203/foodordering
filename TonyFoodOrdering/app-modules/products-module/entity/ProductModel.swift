//
//  ProductModel.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 15/7/21.
//

import Foundation
import ObjectMapper

private let ID = "id"
private let TITLE = "title"
private let BRIEF = "brief"
private let PRICE = "price"
private let STAR = "star"
private let HASPROMO = "hasPromo"
private let PROMOTIONTEXT = "promotionText"
private let IMAGEURL = "imageUrl"

class ProductModel: Mappable {
    
    dynamic var id = ""
    dynamic var title = ""
    dynamic var brief = ""
    dynamic var price = 0.0
    dynamic var star = 0.0
    dynamic var hasPromo = false
    dynamic var promotionText = ""
    dynamic var imageURL = ""
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map) {
        id <- map[ID]
        title <- map[TITLE]
        brief <- map[BRIEF]
        price <- map[PRICE]
        star <- map[STAR]
        hasPromo <- map[HASPROMO]
        promotionText <- map[PROMOTIONTEXT]
        imageURL <- map[IMAGEURL]
    }
}
