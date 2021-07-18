//
//  ProductListModel.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 16/7/21.
//

import Foundation
import UIKit
import ObjectMapper

private let TITLE = "title"
private let TYPE = "type"
private let PRODUCTLIST = "product_list"

public class ProductListModel: Mappable {
    
    dynamic var title = ""
    dynamic var type = ""
    dynamic var productList = [ProductModel]()
    
    required public init?(map:Map) {
        mapping(map: map)
    }

    public func mapping(map:Map) {
        title <- map[TITLE]
        type <- map[TYPE]
        productList <- map[PRODUCTLIST]
    }
    
    func isDrinkProduct() -> Bool {
        if ("DRINK".elementsEqual(type.uppercased())) {
            return true
        }
        return false
    }
}
