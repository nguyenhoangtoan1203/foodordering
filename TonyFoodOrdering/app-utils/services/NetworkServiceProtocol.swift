//
//  NetworkServiceProtocol.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 15/7/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift

public protocol NetworkServiceProtocol {
    
    // MARK: GET
    func get(_ urlString: String, parameters: [String: Any]?, headers: [String: String]?) -> Observable<JSON>
    
    func get(_ urlString: String, headers: [String: String]?) -> Observable<JSON>
    
    func get(_ urlString: String, parameters: [String: Any]?) -> Observable<JSON>
    
    func get(_ urlString: String) -> Observable<JSON>
}
