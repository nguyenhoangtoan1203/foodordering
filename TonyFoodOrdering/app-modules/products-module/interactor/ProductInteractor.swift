//
//  ProductInteractor.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 15/7/21.
//

import Foundation
import Alamofire
import ObjectMapper
import CocoaLumberjack
import RxSwift

class ProductInteractor: ProductPresenterToInteractorProtocol {
    
    var presenter: ProductInteractorToPresenterProtocol?
    let disposeBag = DisposeBag()
    
    func fetchBanner() {
        DDLogDebug("Start fetchBanner")
        
        let service: ProductService = ProductServiceMockImpl.init()
        service.getListBanner().subscribe { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            DDLogDebug("End fetchBanner")
            
            if let json = result.object as? [String: Any] {
                let response = Mapper<BannerModelResponse>().map(JSON: json)
                strongSelf.presenter?.bannerFetchedSuccess(bannerModelArray: response!.data)
            } else {
                strongSelf.presenter?.bannerFetchedSuccess(bannerModelArray: [])
            }
        } onError: { [weak self] (error) in
            guard let strongSelf = self else { return }
            
            DDLogDebug("End fetchBanner")
            strongSelf.presenter?.bannerFetchedSuccess(bannerModelArray: [])
        }.disposed(by: disposeBag)
    }
    
    func fetchProduct() {
        DDLogDebug("Start fetchProduct")
        
        let service: ProductService = ProductServiceMockImpl.init()
        service.getListProduct().subscribe { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            DDLogDebug("End fetchProduct")
            
            if let json = result.object as? [String: Any] {
                let response = Mapper<ProductListModelResponse>().map(JSON: json)
                strongSelf.presenter?.productFetchedSuccess(productListModelArray: response!.data)
            } else {
                strongSelf.presenter?.productFetchFailed()
            }
        } onError: { [weak self] (error) in
            guard let strongSelf = self else { return }
            
            DDLogDebug("End fetchProduct")
            strongSelf.presenter?.productFetchFailed()
        }.disposed(by: disposeBag)
    }
}
