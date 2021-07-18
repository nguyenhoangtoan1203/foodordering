//
//  ProductRouter.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 16/7/21.
//

import UIKit

class ProductRouter : ProductPresenterToRouterProtocol {

    static func createBannerModule(bannerModel: BannerModel) -> UIViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "BannerViewController") as! BannerViewController
        view.bannerModel = bannerModel
        return view
    }
    
    static func createModule() -> UIViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
        
        let presenter: ProductViewToPresenterProtocol & ProductInteractorToPresenterProtocol = ProductPresenter()
        let interactor: ProductPresenterToInteractorProtocol = ProductInteractor()
        
        let router : ProductPresenterToRouterProtocol = ProductRouter()
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
