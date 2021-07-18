//
//  BannerViewController.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 18/7/21.
//

import UIKit
import SDWebImage

class BannerViewController: UIViewController {

    var bannerModel:BannerModel?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
        if (bannerModel != nil && bannerModel!.imageURL.isEmpty == false) {
            let url = URL.init(string: bannerModel!.imageURL)
            imageView.sd_setImage(with: url)
        }
    }
}
