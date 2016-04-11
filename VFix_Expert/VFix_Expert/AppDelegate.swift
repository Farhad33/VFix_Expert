//
//  AppDelegate.swift
//  VFix_Expert
//
//  Created by Dustyn August on 3/10/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import MMDrawerController
//import TPDMapsApp

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var drawerContainer: MMDrawerController?
    var mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var userDefaults = NSUserDefaults.standardUserDefaults()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
//        UIApplication.sharedApplication().statusBarHidden = false
//        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        let username: String = "ndyoussfi"
        let name: String = "Noureddine Youssfi"
        let address_part1: String = "900 Mansell St"
        let address_part2: String = ""
        let phone: String = "4153007403"
        let email: String = "ndyoussfi@gmail.com"
        let state: String = "CA"
        let zip: String = "94134"
        
        userDefaults.setObject(name, forKey: "expert_name")
        userDefaults.setObject(address_part1, forKey: "expert_mail_first")
        userDefaults.setObject(address_part2, forKey: "expert_mail_second")
        userDefaults.setObject(phone, forKey: "expert_phone")
        userDefaults.setObject(email, forKey: "expert_email")
        userDefaults.setObject(state, forKey: "state")
        userDefaults.setObject(zip, forKey: "zip_code")
        userDefaults.setObject(username, forKey: "user_name")

        
        let savedUserName: String? = userDefaults.stringForKey("user_name")
        if savedUserName != nil{
            
            buildInterface()
        
        }
        
        
        
        

        
//        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //appDelegate. // begining of next line
        
        
        
        
        return true
    }
    func buildInterface(){
        let mainPage: DashboardTabBarController = mainStoryBoard.instantiateViewControllerWithIdentifier("DashboardTabBarController") as! DashboardTabBarController
        
        let menu: MenuViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        
        let mainPageNav = UINavigationController(rootViewController: mainPage)
        let menuNav = UINavigationController(rootViewController: menu)
        
        
        drawerContainer = MMDrawerController(centerViewController: mainPageNav, leftDrawerViewController: menuNav)
        
        drawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
        drawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView
        window?.rootViewController?.presentViewController(drawerContainer!, animated: true, completion: nil)
        //window?.rootViewController = drawerContainer
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

