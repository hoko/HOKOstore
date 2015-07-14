//
//  HKSStoreViewController.swift
//  HOKOstore
//
//  Created by Pedro Vieira on 08/07/15.
//  Copyright © 2015 HOKO. All rights reserved.
//

import UIKit

class HKSStoreViewController: UIViewController {
  
  @IBOutlet weak var productsCollectionView: UICollectionView!
  var productsArray = [HKSProduct]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    productsArray.append(HKSProduct.productWithId(0)!)
    productsArray.append(HKSProduct.productWithId(1)!)
    productsArray.append(HKSProduct.productWithId(2)!)
    
    self.setStyledTitle(self.navigationItem.title!)
  }
  
  override func viewWillAppear(animated: Bool) {
    self.setStyledTitle("HOKOStore")
    
    productsCollectionView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: segue method
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let productViewController = segue.destinationViewController as! HKSStoreProductViewController
    productViewController.product = productsArray[(sender as! NSIndexPath).row]
    self.title = " "
  }
}


extension HKSStoreViewController: UICollectionViewDataSource {
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return productsArray.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let viewCell = collectionView.dequeueReusableCellWithReuseIdentifier("productCellIdentifier", forIndexPath: indexPath) as! HKSProductFeedCollectionCellView
    
    let width = CGRectGetWidth(collectionView.frame)
    viewCell.frame.size = CGSize(width: width, height: max(width/2, 227))
    viewCell.frame.origin.x = 0
    
    let product = productsArray[indexPath.row]
    viewCell.updateCellWithProduct(product)
    
    //Here we check if there is an entry on the app's NSUserDefaults with a coupon for
    //the current product. If there is, we show a badge showing the discount percentage.
    //This is a simple and straightfoward example of giving feedback to your user.
    if let coupon = NSUserDefaults.getCouponForProduct("\(product.id)") {
      viewCell.discountBadge.hidden = false
      viewCell.discountBadge.setDiscountPercentage(Int(coupon.discount * 100 / product.price))
    } else {
      viewCell.discountBadge.hidden = true
    }
    
    return viewCell
  }
}


extension HKSStoreViewController: UICollectionViewDelegate {
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("showProductDetailsID", sender: indexPath)
  }
}


