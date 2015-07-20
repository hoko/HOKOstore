//
//  AppDelegate.swift
//  HOKOStore
//
//  Created by Pedro Vieira on 08/07/15.
//  Copyright © 2015 HOKO. All rights reserved.
//

import UIKit

@UIApplicationMain
class HKSAppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    setupHoko()
    
    return true
  }
  
  func setupHoko() {
    //First we setup HOKO using the token given that is given on http://www.hokolinks.com
    //But, for this example, we will you give one that was already created
    //by the HOKO team for testing/displaying purposes.
    Hoko.setupWithToken("9fad9a7b52e539d000c8f1c73a808afcf4ae4851")
    Hoko.setVerbose(true) //we set 'verbose' to 'true' in order to the SDK print messages on the console
    
    //addHandlerBlock will be called every time a deeplink is opened
    //we're just printing a message to acknowledge it.
    Hoko.deeplinking().addHandlerBlock { deeplink in
      print("A wild deep link was caught!\n\n")
    }
    
    //This use case app is used to "sell" products, therefore the route we will use
    //is "product/:product_id"
    Hoko.deeplinking().mapRoute("product/:product_id", toTarget: { deeplink in
      //When a deeplink enteres this route, we know for sure that the routeParameters will contain some data
      //and that it has the key 'product_id'.
      //But, for type safety, we will use optional checking.
      if let productID = deeplink.routeParameters?["product_id"] {
        
        if let product = HKSProduct.productWithId(UInt(productID)!) {
          let productViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Store Product View Controller") as! HKSStoreProductViewController
          
          productViewController.product = product
          
          //____ This is the core part of this Use Case app ____
          //
          //>> http://black.hoko.link/save20 << this is the link we're using for this example
          //
          //We will check if the deeplink's metada dictionary contains the key 'coupon' which is its code (e.g. save20)
          //and the key 'value' which is its discount value (e.g. $20).
          //
          //Keep in mind that this keys are not guaranteed to be in every smartlink because they're optional,
          //so make sure that you still present the Product's View Controller even if there is no coupon
          if let couponCode = deeplink.metadata?["coupon"] as? String, discount = Float(deeplink.metadata?["value"] as! String) {
            let coupon = HKSCoupon(name: couponCode, discount: discount)
            
            //we will save on the app's NSUserDefaults that the user already has redeemed a coupon for product X
            //which will be used later to show a discount badge on that product's cell
            NSUserDefaults.saveCoupon(coupon, forProduct: String(productID))
            
            productViewController.newlyRedeemedCoupon = coupon
          }
          
          //We present the Product View Controller whether the link contained a coupon metadata entry or not
          HOKNavigation.pushViewController(productViewController, animated: true, replace: true)
          
        } else {
          self.window?.rootViewController?.presentViewController(UIAlertController.alertWithTitle("Oops!", message: "Unfortunately we couldn't find that product", buttonTitle: "Bummer"), animated: true, completion: nil)
        }
      }
    })
  }
  
  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  
}

