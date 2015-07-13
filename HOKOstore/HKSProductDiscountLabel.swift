//
//  HKSProductDiscountLabel.swift
//  HOKOstore
//
//  Created by Pedro Vieira on 13/07/15.
//  Copyright © 2015 HOKO. All rights reserved.
//

import UIKit

class HKSProductDiscountLabel: UILabel {
    func setTitleWithPrice(price: Float, discount: Float?) {
        if let disc = discount {
            let priceString = "$\(price - disc) / $\(price)"
            let attributedString = NSMutableAttributedString(string:priceString)
            
            let discountPriceString = "$\(price - disc)"
            let basePriceString = "$\(price)"
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSRange(location: 0, length: discountPriceString.characters.count))
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location: discountPriceString.characters.count + 3, length: basePriceString.characters.count))
            attributedString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSRange(location: discountPriceString.characters.count + 3, length: basePriceString.characters.count))
            
            self.attributedText = attributedString
        } else {
            self.text = "$\(price)"
        }
    }
}
