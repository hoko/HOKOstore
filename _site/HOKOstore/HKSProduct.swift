//
//  HKSProduct.swift
//  HOKOstore
//
//  Created by Pedro Vieira on 08/07/15.
//  Copyright © 2015 HOKO. All rights reserved.
//

import Foundation

struct HKSProduct {
    var title: String
    var description: String
    var image: UIImage
    var price: Float
    
    init(_ title: String, description: String, image: UIImage, price: Float) {
        self.title = title
        self.description = description
        self.image = image
        self.price = price
    }
    
    
}

