//
//  HKSProduct.swift
//  HOKOstore
//
//  Created by Pedro Vieira on 08/07/15.
//  Copyright © 2015 HOKO. All rights reserved.
//

import Foundation


//The struct that represents a Product in HOKOstore
struct HKSProduct {
    let id: UInt
    let title: String
    let description: String
    let image: UIImage
    let price: Float
    
    init(id: UInt, title: String, description: String, image: UIImage, price: Float) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        self.price = price
    }
    
    static func productWithId(productID: UInt) -> HKSProduct? {
        switch (productID) {
        case 0:
            return HKSProduct(id: productID, title: "Awesome Book", description: "The best book ever made, trust us.", image: UIImage(named: "book")!, price: 52.99)
        case 1:
            return HKSProduct(id: productID, title: "Shiny Boots", description: "Who wouldn't want to use this shiny hand-made boots?", image: UIImage(named: "boots")!, price: 29.99)
        case 2:
            return HKSProduct(id: productID, title: "Phone Case", description: "Feels like silk in your hands. Your phone will love it, we guarantee you.", image: UIImage(named: "case")!, price: 39.99)
        default:
            return nil
        }
    }
}
