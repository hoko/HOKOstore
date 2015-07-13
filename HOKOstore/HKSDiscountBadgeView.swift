//
//  HKSDiscountBadgeView.swift
//  HOKOstore
//
//  Created by Pedro Vieira on 09/07/15.
//  Copyright © 2015 HOKO. All rights reserved.
//

import UIKit

class HKSDiscountBadgeView: UIView {
    
    var percentage: Int?
    
    override func awakeFromNib() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
    func setDiscountPercentage(perc: Int) {
        percentage = perc > 100 ? 100 : perc
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        if percentage != nil {
            let string = percentage == 100 ? "FREE" : "-\(percentage!)%"
            
            let paraStyle = NSMutableParagraphStyle()
            paraStyle.alignment = .Center
            
            let attributes = [
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSParagraphStyleAttributeName: paraStyle,
                NSFontAttributeName: UIFont.boldSystemFontOfSize(13)
            ]
            
            var r = rect
            r.origin.y = (self.frame.size.height / 2) - 8.5
            string.drawInRect(r, withAttributes: attributes)
        }
    }
    
}
