//
//  ProductViewController.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 16/7/21.
//

import UIKit
import CocoaLumberjack
import DNSPageView
import MBProgressHUD

class ProductViewController: UIViewController {

    var presenter:ProductViewToPresenterProtocol?
      
    @IBOutlet weak var uiTableView: UITableView!
    var headerView: ParallaxView!
    
    var productListArrayList:Array<ProductListModel> = Array()
    var producModelArrayList:Array<ProductModel> = Array()
    var isDrinkType : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        headerView = ParallaxView.init(height: 320, fixed: false)
        headerView.backgroundColor = .white
        headerView?.attachTo(scrollView: uiTableView)
        headerView?.maxHeight = 450
        
        uiTableView.delegate = self
        uiTableView.dataSource = self
                                 
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        presenter?.startFetchingBanner()
        presenter?.startFetchingProduct()
    }
}

extension ProductViewController : ProductPresenterToViewProtocol {
    func showBanner(bannerModelArray: Array<BannerModel>) {
        DDLogDebug("Has \(bannerModelArray.count) banners")
        
        let style = PageStyle()
        style.isTitleViewScrollEnabled = true
        style.isTitleScaleEnabled = true
        style.titleViewHeight = -60.0

        var titles: [String] = []
        var childViewControllers: [UIViewController] = []
        for bannerModel in bannerModelArray {
            let bannerItemView = ProductRouter.createBannerModule(bannerModel: bannerModel)
            childViewControllers.append(bannerItemView)
            titles.append(bannerModel.title)
        }
        
        let pageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: headerView.bounds.height - 20, width: headerView.bounds.width, height: 20))
        pageControl.numberOfPages = childViewControllers.count
        pageControl.currentPage = 0

        let pageView = PageView(frame: CGRect(x: 0, y: 0, width: headerView.bounds.width, height: headerView.bounds.height), style: style, titles: titles, childViewControllers: childViewControllers)
        headerView.addSubview(pageView)
        headerView.addSubview(pageControl)
        
        // TODO: set auto-slide for banner
        
        // TODO: update page controler index when change banners
    }
    
    func showProduct(productListArray: Array<ProductListModel>) {
        DDLogDebug("Has \(productListArray.count) products")
        
        MBProgressHUD.hide(for: self.view, animated: true)
        
        self.productListArrayList = productListArray
        self.producModelArrayList = productListArray[0].productList
        self.isDrinkType = productListArray[0].isDrinkProduct()
        self.uiTableView.reloadData()
        
        let productTitleView = ProductTitleView.init(frame: CGRect(x: 0, y: 0, width: self.uiTableView.bounds.size.width , height: 50))
        productTitleView.bindingData(productListArray: productListArray)
        productTitleView.delegate = self
        self.uiTableView.tableHeaderView = productTitleView
    }
    
    func showError() {
        DDLogDebug("showError")
        MBProgressHUD.hide(for: self.view, animated: true)
        
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Product", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProductViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return producModelArrayList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width / 2 + (self.isDrinkType ? 110 : 150)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "ProductTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? ProductTableViewCell
        if cell == nil {
            cell = ProductTableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
            cell?.selectionStyle = .none
            cell?.delegate = self
        }
        
        let product = self.producModelArrayList[indexPath.row] as ProductModel
        cell?.bindingData(product: product)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView?.scrollViewDidScroll(scrollView: scrollView)
    }
}

extension ProductViewController : ProductTitleViewDelegate {
    func onProductTypeBtnClicked(productListIndex: Int) {
        if (productListIndex < self.productListArrayList.count) {
            self.producModelArrayList = self.productListArrayList[productListIndex].productList
            self.isDrinkType = self.productListArrayList[productListIndex].isDrinkProduct()
            
            self.uiTableView.reloadData()
        }
    }
}

extension ProductViewController : ProductTableViewCellDelegate {
    func onAddToCartBtnClicked(sender: ProductTableViewCell) {
        let indexPath = self.uiTableView.indexPath(for: sender)
        // TODO: handle add item to cart
    }
}
