//
//  NetworkService.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 15/7/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxSwift

open class NetworkService: NSObject, NetworkServiceProtocol {
    
    var requests = [DataRequest]()
    var requestManager: Alamofire.SessionManager
    
    override init() {
        let config = URLSessionConfiguration.default
        // TODO: add config if needed
        requestManager = Alamofire.SessionManager(configuration: config)
    }

    // MARK: GET
    open func get(_ urlString: String, parameters: [String: Any]?, headers: [String: String]?) -> Observable<JSON> {
        return Observable.create { [weak self] observer in
            weak var _request: DataRequest?
            guard let _self = self else { return Disposables.create {} }
            let request = _self.requestManager.request(urlString, method: .get, parameters: parameters, headers: headers)
            _request = request
            _self.requests.append(request)

            // Get reponse as JSON
            request.responseJSON { response in
                if let error = response.result.error {
                    observer.onError(error)
                } else {
                    if let json = response.result.value {
                        observer.onNext(JSON(json))
                    } else {
                        observer.onNext(JSON([])) // result is empty
                    }
                }
                
                // Complete the stream
                observer.onCompleted()
            }
            
            return Disposables.create {
                guard let _self = self, let request = _request else {return}
                _self.requests = _self.requests.filter { $0 !== request }
                request.cancel()
            }
        }
    }
    
    open func get(_ urlString: String, headers: [String: String]?) -> Observable<JSON> {
        return get(urlString, parameters: nil, headers: headers)
    }
    
    open func get(_ urlString: String, parameters: [String: Any]?) -> Observable<JSON> {
        return get(urlString, parameters: parameters, headers: nil)
    }
    
    open func get(_ urlString: String) -> Observable<JSON> {
        return get(urlString, parameters: nil, headers: nil)
    }
}
