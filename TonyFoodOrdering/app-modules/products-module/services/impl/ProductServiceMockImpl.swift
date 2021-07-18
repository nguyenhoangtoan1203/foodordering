//
//  ProductServiceMockImpl.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 18/7/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxSwift
import CocoaLumberjack

final class ProductServiceMockImpl: NetworkService, ProductService {
    
    var disposeBag: DisposeBag = DisposeBag()
    var bannerApiUrl: String = "https://google.com/banner"
    var productApiUrl: String = "https://google.com/product"
    
    func getListBanner() -> Observable<JSON> {
        DDLogDebug("Start getListBannerMockup")
        
        let apiUrl = self.bannerApiUrl
        
        return Observable.create { observer in
            // Get mock data from products.json
            var data = JSON.init(parseJSON: "")
            if let filePath = Bundle.main.path(forResource: "banners", ofType: "json") {
                do {
                    let contents = try String(contentsOfFile: filePath)
                    data = JSON.init(parseJSON: contents)
                } catch {
                   
                }
            } else {
                DDLogDebug("File not found")
            }
            
            return self.get(apiUrl)
                .subscribe(onNext: { result in
                    DDLogDebug("End getListBannerMockup")
                    observer.onNext(data)
                    observer.onCompleted()
                }, onError: { error in
                    DDLogDebug("End getListBannerMockup")
                    observer.onNext(data)
                    observer.onCompleted()
                })
        }
    }
    
    func getListProduct() -> Observable<JSON> {
        DDLogDebug("Start getListProductMockup")
        
        let apiUrl = self.productApiUrl
        
        return Observable.create { observer in
            // Get mock data from products.json
            var data = JSON.init(parseJSON: "")
            if let filePath = Bundle.main.path(forResource: "products", ofType: "json") {
                do {
                    let contents = try String(contentsOfFile: filePath)
                    data = JSON.init(parseJSON: contents)
                } catch {
                   
                }
            } else {
                DDLogDebug("File not found")
            }
            
            return self.get(apiUrl)
                .subscribe(onNext: { result in
                    DDLogDebug("End getListProductMockup")
                    observer.onNext(data)
                    observer.onCompleted()
                }, onError: { error in
                    DDLogDebug("End getListProductMockup")
                    observer.onNext(data)
                    observer.onCompleted()
                })
        }
    }
}
