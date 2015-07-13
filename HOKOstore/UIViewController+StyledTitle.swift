//
//  UIViewController+StyledTitle.swift
//  HOKOstore
//
//  Created by Pedro Vieira on 08/07/15.
//  Copyright © 2015 HOKO. All rights reserved.
//

import UIKit

extension UIViewController {
    func setStyledTitle(title: String) {
        var label: UILabel
        if let titleLabel = self.navigationItem.titleView as? UILabel {
            label = titleLabel
        } else {
            label = UILabel()
        }
        
        let font = UIFont(name: "Novecentosanswide-DemiBold", size: 14)
        label.font = font
        label.textColor = UIColor.blackColor()
        label.attributedText = NSAttributedString(string: title)
        label.sizeToFit()
        self.navigationItem.titleView = label
    }
}