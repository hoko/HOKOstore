//
//  HKSStoreViewController.swift
//  HOKOstore
//
//  Created by Pedro Vieira on 08/07/15.
//  Copyright © 2015 HOKO. All rights reserved.
//

import UIKit

class HKSStoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var productsCollectionView: UICollectionView!
    var productsArray: [HKSProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        productsArray.append(HKSProduct("Awesome Book", description: "sdadadas", image: UIImage(named: "book")!, price: 100))
        productsArray.append(HKSProduct("Socas", description: "sdadadas", image: UIImage(named: "a")!, price: 100))
        productsArray.append(HKSProduct("Calças", description: "sdadadas", image: UIImage(named: "a")!, price: 100))
        
        productsCollectionView.reloadData()
        
        self.setStyledTitle(self.navigationItem.title!)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.setStyledTitle("HOKOstore")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDelegate and UICollectionViewDataSource methods
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let viewCell = collectionView.dequeueReusableCellWithReuseIdentifier("productCellIdentifier", forIndexPath: indexPath) as! HKSProductFeedCollectionCellView
        
        viewCell.updateCellWithProduct(productsArray[indexPath.row])
        
        return viewCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showProductDetailsID", sender: indexPath)
    }
    
    // MARK: segue method
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! HKSStoreProductViewController
        vc.product = productsArray[(sender as! NSIndexPath).row]
        self.title = " "
    }
}

