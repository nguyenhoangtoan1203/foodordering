//
//  ProductTitleView.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 18/7/21.
//

import UIKit

public protocol ProductTitleViewDelegate : NSObjectProtocol {
    func onProductTypeBtnClicked(productListIndex: Int) -> Void
}

public class ProductTitleView: UIView {
    
    weak open var delegate: ProductTitleViewDelegate?
    
    var currentIndex = 0
    var buttons: [UIButton] = []
        
    func bindingData(productListArray: Array<ProductListModel>) -> Void {
        buttons.removeAll()
        
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: bounds.width, height: bounds.height))
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
        var minX = CGFloat(10)
        for index in 0..<productListArray.count {
            let productList = productListArray[index]
            let item = UIButton.init(frame: CGRect.init(x: minX, y: 15, width: 80, height: bounds.height))
            item.setTitle(productList.title, for: .normal)
            item.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
            item.setTitleColor(UIColor.lightGray, for: .normal)
            item.setTitleColor(UIColor.black, for: .selected)
            item.setTitleColor(UIColor.black, for: .highlighted)
            item.clipsToBounds = true
            item.tag = index
            item.addTarget(self, action:#selector(onProductTypeBtnClicked) , for: .touchUpInside)
            scrollView.addSubview(item)
            buttons.append(item)
            minX = item.frame.maxX + 10
        }
        
        buttons[currentIndex].isSelected = true
        scrollView.contentSize = CGSize(width: minX, height:frame.height)
    }
    
    @objc func onProductTypeBtnClicked(sender: UIButton) {
        delegate?.onProductTypeBtnClicked(productListIndex: sender.tag)
        for button in buttons {
            if (button.tag == sender.tag) {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }
}
