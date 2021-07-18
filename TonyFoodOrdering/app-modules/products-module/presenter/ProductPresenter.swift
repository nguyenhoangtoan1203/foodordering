//
//  ProductPresenter.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 15/7/21.
//

import Foundation
import UIKit

class ProductPresenter:ProductViewToPresenterProtocol {
    
    var view: ProductPresenterToViewProtocol?
    var interactor: ProductPresenterToInteractorProtocol?
    var router: ProductPresenterToRouterProtocol?
    
    func startFetchingBanner() {
        interactor?.fetchBanner()
    }
    
    func startFetchingProduct() {
        interactor?.fetchProduct()
    }
    
    func showCartController(navigationController: UINavigationController) {
        // TODO
    }
}

extension ProductPresenter: ProductInteractorToPresenterProtocol {
    
    func bannerFetchedSuccess(bannerModelArray: Array<BannerModel>) {
        view?.showBanner(bannerModelArray: bannerModelArray)
    }
    
    func productFetchedSuccess(productListModelArray:Array<ProductListModel>) {
        view?.showProduct(productListArray: productListModelArray)
    }
    
    func productFetchFailed() {
        view?.showError()
    }
}
