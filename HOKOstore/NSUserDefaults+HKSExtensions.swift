//
//  NSUserDefaults+HKSExtensions.swift
//  HOKOstore
//
//  Created by Pedro Vieira on 13/07/15.
//  Copyright © 2015 HOKO. All rights reserved.
//

import Foundation

extension NSUserDefaults {
  static func saveCoupon(coupon: HKSCoupon, forProduct productID: String) {
    NSUserDefaults().setObject(["name": coupon.name, "discount": coupon.discount], forKey: productID)
  }
  
  static func getCouponForProduct(productID: String) -> HKSCoupon? {
    if let dict = NSUserDefaults().dictionaryForKey(productID) {
      return HKSCoupon(name: dict["name"] as! String, discount: dict["discount"] as! Float)
    }
    
    return nil
  }
}