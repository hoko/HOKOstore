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
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    var product: HKSProduct?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setStyledTitle(product!.title)
        productImageView.image = product!.image
        productTitleLabel.text = product!.title
        productDescriptionLabel.text = product!.description
    }
    
    @IBAction func buyProduct(sender: AnyObject) {
        let alertController = UIAlertController(title: "Thank you!",
            message: "An e-pidgeon will soon arrive at your destination with your product.", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Awesome!", style: .Default, handler: nil)
        alertController.addAction(action)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
