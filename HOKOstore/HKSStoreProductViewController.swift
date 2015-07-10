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
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    var product: HKSProduct!
    var newlyReedemedCoupon: Float?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setStyledTitle(product.title)
        productImageView.image = product.image
        productTitleLabel.text = product.title
        productDescriptionLabel.text = product.description
        
        let discount = NSUserDefaults().floatForKey("product: \(product.id)")
        if discount > 0 {
            let priceString = "$\(product.price - discount) / $\(product.price)"
            let attributedString = NSMutableAttributedString(string:priceString)
            
            let discountPriceString = "$\(product.price - discount)"
            let basePriceString = "$\(product.price)"
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSRange(location: 0, length: discountPriceString.characters.count))
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location: discountPriceString.characters.count + 3, length: basePriceString.characters.count))
            attributedString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSRange(location: discountPriceString.characters.count + 3, length: basePriceString.characters.count))
            
            priceLabel.attributedText = attributedString
            
        } else {
            priceLabel.text = "$\(product.price)"
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if let coupon = newlyReedemedCoupon {
            self.presentViewController(UIAlertController.showAlertWithTitle("Congratulations",
                message: "You just earned $\(coupon) through a coupon because you clicked on the right link!",
                buttonTitle: "Awesome!"),
            animated: true, completion: nil)
        }
    }
    
    @IBAction func buyProduct(sender: AnyObject) {
        self.presentViewController(UIAlertController.showAlertWithTitle("Thank you",
            message: "An e-pidgeon will arrive shortly at your destination with your shiny new product.",
            buttonTitle: "Alright!"),
        animated: true, completion: nil)
    }
}
