//
//  ProductServiceImpl.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 18/7/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxSwift
import CocoaLumberjack

final class ProductServiceImpl: NetworkService, ProductService {
    
    var disposeBag: DisposeBag = DisposeBag()
    var bannerApiUrl: String = "https://google.com/banner"
    var productApiUrl: String = "https://google.com/product"
    
    func getListBanner() -> Observable<JSON> {
        DDLogDebug("Start getListBanner")
        
        let apiUrl = self.bannerApiUrl
        
        return Observable.create { observer in
            self.get(apiUrl)
                .subscribe(onNext: { result in
                    DDLogDebug("End getListBanner")
                    observer.onNext(result)
                    observer.onCompleted()
                }, onError: { error in
                    DDLogDebug("End getListBanner with error: \(error)")
                    observer.onError(error)
                    observer.onCompleted()
                }).disposed(by: self.disposeBag)
            
            return Disposables.create {
                // Cancel things
                DDLogDebug("Cancel getListBanner")
            }
        }
    }
    
    func getListProduct() -> Observable<JSON> {
        DDLogDebug("Start getListProduct")
        
        let apiUrl = self.productApiUrl
        
        return Observable.create { observer in
            self.get(apiUrl)
                .subscribe(onNext: { result in
                    DDLogDebug("End getListProduct")
                    observer.onNext(result)
                    observer.onCompleted()
                }, onError: { error in
                    DDLogDebug("End getListProduct with error: \(error)")
                    observer.onError(error)
                    observer.onCompleted()
                }).disposed(by: self.disposeBag)
            
            return Disposables.create {
                // Cancel things
                DDLogDebug("Cancel getListProduct")
            }
        }
    }
}
