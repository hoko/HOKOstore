//
//  HKSCoupon.swift
//  HOKOstore
//
//  Created by Pedro Vieira on 13/07/15.
//  Copyright © 2015 HOKO. All rights reserved.
//

import Foundation

struct HKSCoupon {
    let name: String
    let discount: Float
    
    init(name: String, discount: Float) {
        self.name = name
        self.discount = discount
    }
}