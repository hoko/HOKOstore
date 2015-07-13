//
//  HKSStoreProductViewController.swift
//  HOKOstore
//
//  Created by Pedro Vieira on 08/07/15.
//  Copyright © 2015 HOKO. All rights reserved.
//

import UIKit

class HKSStoreProductViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: HKSProductDiscountLabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    var product: HKSProduct!
    var newlyReedemedCoupon: HKSCoupon?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setStyledTitle(product.title)
        productImageView.image = product.image
        productTitleLabel.text = product.title
        productDescriptionLabel.text = product.description
        
        
        priceLabel.setTitleWithPrice(product.price, discount: NSUserDefaults.getCouponForProduct("\(product.id)")?.discount)
    }
    
    override func viewDidAppear(animated: Bool) {
        if let coupon = newlyReedemedCoupon {
            self.presentViewController(UIAlertController.alertWithTitle("Congratulations",
                message: "You just reedemed '\(coupon.name)' coupon and received a discount of $\(coupon.discount) because you clicked on the right link!",
                buttonTitle: "Awesome!"),
            animated: true, completion: nil)
        }
    }
    
    @IBAction func buyProduct(sender: AnyObject) {
        self.presentViewController(UIAlertController.alertWithTitle("Thank you",
            message: "An e-pidgeon will arrive shortly at your destination with your shiny new product.",
            buttonTitle: "Alright!"),
        animated: true, completion: nil)
    }
}
