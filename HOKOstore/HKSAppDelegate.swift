//
//  AppDelegate.swift
//  HOKOstore
//
//  Created by Pedro Vieira on 08/07/15.
//  Copyright © 2015 HOKO. All rights reserved.
//

import UIKit

@UIApplicationMain
class HKSAppDelegate: UIResponder, UIApplicationDelegate {

    let HKSUserSignedInDefaultsKey = "HKSUserSignedIn"
    
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupHoko()
        showSignInViewIfNeeded()
        //NSUserDefaults.standardUserDefaults().removePersistentDomainForName(NSBundle.mainBundle().bundleIdentifier!)
        
        return true
    }
    
    func setupHoko() {
        Hoko.setupWithToken("9fad9a7b52e539d000c8f1c73a808afcf4ae4851")
        Hoko.setVerbose(true)
        

        Hoko.deeplinking().addHandlerBlock { deeplink in
            print("A wild deep link was caught!\n\n")
        }
        
        Hoko.deeplinking().mapRoute("product/:product_id", toTarget: { deeplink in
            let productID = deeplink.routeParameters?["product_id"]! as! String
            if let product = HKSProduct.productWithId(UInt(productID)!) {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Store Product View Controller") as! HKSStoreProductViewController
                
                vc.product = product
                
                if let couponCode = deeplink.metadata?["coupon"] as? String, discount = Float(deeplink.metadata?["value"] as! String) {
                    let coupon = HKSCoupon(name: couponCode, discount: discount)
                    NSUserDefaults.saveCoupon(coupon, forProduct: productID)
                    vc.newlyReedemedCoupon = coupon
                }
                
                HOKNavigation.pushViewController(vc, animated: true, replace: true)
            } else {
                self.window?.rootViewController?.presentViewController(UIAlertController.alertWithTitle("Oops!", message: "Unfortunately we couldn't find that product", buttonTitle: "Bummer"), animated: true, completion: nil)
            }
        })
    }
    
    func showSignInViewIfNeeded() {
        if !NSUserDefaults().boolForKey(HKSUserSignedInDefaultsKey) {
            print("TEST: should show sign in panel \n\n\n\n\n\n")
            //defaults.setBool(true, forKey: HKSUserSignedInDefaultsKey)
        }
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

