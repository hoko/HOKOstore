//
//  UIAlertController+Extension.swift
//  HOKOstore
//
//  Created by Pedro Vieira on 09/07/15.
//  Copyright © 2015 HOKO. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func alertWithTitle(title: String, message: String, buttonTitle: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: buttonTitle, style: .Default, handler: nil)
        alertController.addAction(action)
        
        return alertController
    }
}