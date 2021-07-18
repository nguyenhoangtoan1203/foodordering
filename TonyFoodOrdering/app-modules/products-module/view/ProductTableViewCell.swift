//
//  ProductTableViewCell.swift
//  TonyFoodOrdering
//
//  Created by Toan Nguyen on 18/7/21.
//

import UIKit
import CocoaLumberjack
import SDWebImage

public protocol ProductTableViewCellDelegate : NSObjectProtocol {
    func onAddToCartBtnClicked(sender: ProductTableViewCell) -> Void
}

public class ProductTableViewCell: UITableViewCell {
    
    weak open var delegate: ProductTableViewCellDelegate?
    
    weak var wrapperView: UIView!
    weak var titleLbl: UILabel!
    weak var briefLbl: UILabel!
    weak var promotionLbl: UILabel!
    weak var starIcon: UIImageView!
    weak var starLbl: UILabel!
    weak var promotionIcon: UIImageView!
    weak var productImageView: UIImageView!
    weak var addToCardBtn: UIButton!
    weak var addToCardNoti: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() -> Void {
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.clipsToBounds = true
        
        let wrapperView = UIView(frame: CGRect.zero)
        wrapperView.backgroundColor = UIColor.white
        wrapperView.clipsToBounds = true
        contentView.addSubview(wrapperView)
        self.wrapperView = wrapperView
        
        let productImageView = UIImageView(frame: CGRect.zero)
        productImageView.contentMode = .scaleToFill
        productImageView.clipsToBounds = true
        productImageView.backgroundColor = .clear
        wrapperView.addSubview(productImageView)
        self.productImageView = productImageView
        
        let titleLbl = UILabel(frame: CGRect.zero)
        titleLbl.textAlignment = .left
        titleLbl.backgroundColor = UIColor.clear
        titleLbl.font = UIFont.boldSystemFont(ofSize: 15)
        titleLbl.numberOfLines = 2
        wrapperView.addSubview(titleLbl)
        self.titleLbl = titleLbl
        
        let briefLbl = UILabel(frame: CGRect.zero)
        briefLbl.textAlignment = .left
        briefLbl.backgroundColor = UIColor.clear
        briefLbl.font = UIFont.systemFont(ofSize: 13)
        briefLbl.numberOfLines = 1
        briefLbl.textColor = .darkGray
        wrapperView.addSubview(briefLbl)
        self.briefLbl = briefLbl
        
        let promoIcon = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 30))
        promoIcon.contentMode = .scaleToFill
        promoIcon.backgroundColor = .clear
        promoIcon.image = UIImage.init(named: "icon_promo")
        promoIcon.clipsToBounds = true
        wrapperView.addSubview(promoIcon)
        self.promotionIcon = promoIcon
        
        let promotionLbl = UILabel(frame: CGRect.zero)
        promotionLbl.textAlignment = .left
        promotionLbl.backgroundColor = UIColor.clear
        promotionLbl.font = UIFont.systemFont(ofSize: 13)
        promotionLbl.numberOfLines = 2
        wrapperView.addSubview(promotionLbl)
        self.promotionLbl = promotionLbl
        
        let starIconSize = CGFloat(14)
        let starIcon = UIImageView(frame: CGRect.init(x: 0, y: 0, width: starIconSize, height: starIconSize))
        starIcon.contentMode = .scaleAspectFit
        starIcon.backgroundColor = .clear
        starIcon.image = UIImage.init(named: "icon_star")
        wrapperView.addSubview(starIcon)
        self.starIcon = starIcon
        
        let starLbl = UILabel(frame: CGRect.zero)
        starLbl.textAlignment = .left
        starLbl.backgroundColor = UIColor.clear
        starLbl.font = UIFont.systemFont(ofSize: 13)
        starLbl.numberOfLines = 1
        starLbl.textColor = .darkGray
        wrapperView.addSubview(starLbl)
        self.starLbl = starLbl
        
        let addToCardBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 28))
        addToCardBtn.backgroundColor = UIColor.systemGreen
        addToCardBtn.setTitle("", for: .normal)
        addToCardBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        addToCardBtn.setTitleColor(UIColor.white, for: .normal)
        addToCardBtn.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .selected)
        addToCardBtn.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        addToCardBtn.layer.borderWidth = 0.0
        addToCardBtn.layer.cornerRadius = 8
        addToCardBtn.clipsToBounds = true
        wrapperView.addSubview(addToCardBtn)
        self.addToCardBtn = addToCardBtn
        
        let addToCardNoti = UILabel(frame: addToCardBtn.frame)
        addToCardNoti.text = "added +1"
        addToCardNoti.textColor = UIColor.white
        addToCardNoti.textAlignment = .center
        addToCardNoti.backgroundColor = UIColor.systemPink
        addToCardNoti.font = UIFont.systemFont(ofSize: 12)
        addToCardNoti.numberOfLines = 1
        addToCardNoti.layer.borderWidth = 0.0
        addToCardNoti.layer.cornerRadius = 8
        addToCardNoti.clipsToBounds = true
        addToCardNoti.isHidden = true
        wrapperView.addSubview(addToCardNoti)
        self.addToCardNoti = addToCardNoti
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl?.text = nil
        briefLbl?.text = nil
        promotionLbl?.text = nil
        starLbl?.text = nil
        productImageView?.image = nil
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding = CGFloat(16)
        let space = CGFloat(8)
        let width = frame.width - 2 * padding
        
        wrapperView.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height - 1)
        productImageView.frame = CGRect.init(x: padding, y: padding, width: width, height: width / 2.0)
        titleLbl.frame = CGRect.init(x: padding, y: productImageView.frame.maxY + space, width: width, height: 36)
        
        addToCardBtn.frame = CGRect.init(x: width - addToCardBtn.bounds.width + padding, y: titleLbl.frame.maxY, width: addToCardBtn.bounds.width, height: addToCardBtn.bounds.height)
        addToCardNoti.frame = CGRect.init(x: width - addToCardBtn.bounds.width + padding, y: titleLbl.frame.maxY, width: addToCardBtn.bounds.width, height: addToCardBtn.bounds.height)
        
        starIcon.frame = CGRect.init(x: padding, y: titleLbl.frame.maxY + space, width: starIcon.bounds.width, height: starIcon.bounds.height)
        starLbl.frame = CGRect.init(x: starIcon.frame.maxX + space, y: starIcon.frame.minX, width: width / 2, height: 15)
        starIcon.center.y = addToCardBtn.center.y
        addToCardNoti.center = addToCardBtn.center
        starLbl.center.y = starIcon.center.y
        
        briefLbl.frame = CGRect.init(x: padding, y: addToCardBtn.frame.maxY + space, width: width, height: 15)
        promotionLbl.frame = CGRect.init(x: padding, y: briefLbl.frame.maxY + space, width: width, height: 36)
        promotionIcon.frame = CGRect.init(x: padding, y: padding, width: promotionIcon.bounds.width, height: promotionIcon.bounds.height)
    }
    
    func bindingData(product: ProductModel) -> Void {
        DDLogDebug("bindingData for product: \(product.title)")
        
        titleLbl.text = product.title
        titleLbl.sizeToFit()
        
        addToCardBtn.setTitle(String.init(format: "S$ %.2f", product.price), for: .normal)
        briefLbl.text = product.brief
        
        starLbl.text = String.init(format: "%.1f", product.star)
        starLbl.isHidden = !(product.star > 0.0)
        starIcon.isHidden = !(product.star > 0.0)
        
        promotionIcon.isHidden = !(product.hasPromo)
        promotionLbl.text = product.promotionText
        promotionLbl.sizeToFit()
        
        if (product.imageURL.isEmpty == false) {
            let url = URL.init(string: product.imageURL)
            productImageView.sd_setImage(with: url)
        }
        
        addToCardBtn.addTarget(self, action:#selector(onAddToCartBtnClicked) , for: .touchUpInside)
    }
    
    @objc func onAddToCartBtnClicked(sender: UIButton?) {
        delegate?.onAddToCartBtnClicked(sender: self)
        animated()
    }
    
    func animated() -> Void {
        addToCardNoti.alpha = 0.0
        addToCardNoti.isHidden = false
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [self] in
            self.addToCardNoti.alpha = 1.0
        } completion: { (completed) in
            UIView.animate(withDuration: 0.3, delay: 0.4, options: .curveLinear) {
                self.addToCardNoti.alpha = 0.0
            } completion: { (completed) in
                self.addToCardNoti.isHidden = true
            }
        }
    }
}
