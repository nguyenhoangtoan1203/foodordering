//
//  ProductService.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 18/7/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxSwift

protocol ProductService: class {
    var disposeBag : DisposeBag {get set}
    
    var bannerApiUrl : String {get set}
    var productApiUrl : String {get set}
    
    func getListBanner() -> Observable<JSON>
    func getListProduct() -> Observable<JSON>
}
