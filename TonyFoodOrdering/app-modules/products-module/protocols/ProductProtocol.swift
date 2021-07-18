//
//  ProductProtocol.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 15/7/21.
//

import Foundation
import UIKit

protocol ProductViewToPresenterProtocol: class {
    var view: ProductPresenterToViewProtocol? {get set}
    var interactor: ProductPresenterToInteractorProtocol? {get set}
    var router: ProductPresenterToRouterProtocol? {get set}

    func startFetchingBanner()
    func startFetchingProduct()

    func showCartController(navigationController:UINavigationController)
}

protocol ProductPresenterToViewProtocol: class {
    func showBanner(bannerModelArray:Array<BannerModel>)
    func showProduct(productListArray:Array<ProductListModel>)
    func showError()
}

protocol ProductPresenterToRouterProtocol: class {
    static func createModule()-> UIViewController
    static func createBannerModule(bannerModel: BannerModel) -> UIViewController
}

protocol ProductPresenterToInteractorProtocol: class {
    var presenter:ProductInteractorToPresenterProtocol? {get set}
    func fetchBanner()
    func fetchProduct()
}

protocol ProductInteractorToPresenterProtocol: class {
    func bannerFetchedSuccess(bannerModelArray:Array<BannerModel>)
    func productFetchedSuccess(productListModelArray:Array<ProductListModel>)
    func productFetchFailed()
}
