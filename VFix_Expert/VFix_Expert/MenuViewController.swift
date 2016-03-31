//
//  MenuViewController.swift
//  VFix_Expert
//
//  Created by Noureddine Youssfi on 3/19/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
//import DrawerController
import MMDrawerController

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var menuItems: [String] = ["Dashboard", "Profile", "Schedule", "Payroll", "Settings", "My card", "Ratings", "Log Out"]
    var menuIcons: [String] = ["Dashboard.png", "Profile.png", "Schedule.png", "Pay.png", "Settings.png", "Card.png", "Ratings.png", "Logout.png"]
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var menuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        menuTableView.delegate = self
//        menuTableView.dataSource = self
//        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
//        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.menuTableView.scrollEnabled = false
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
//        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        
    }
    
//    override func viewWillAppear(animated: Bool) {
//        self.viewWillAppear(true)
//        self.navigationController?.navigationBarHidden = false
//    }
//    override func viewWillDisappear(animated: Bool) {
//        self.viewWillDisappear(true)
//        self.navigationController?.navigationBarHidden = false
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let menuCell = menuTableView.dequeueReusableCellWithIdentifier("expertCell", forIndexPath: indexPath) as! MenuCell
        menuCell.menuItem.text = menuItems[indexPath.row]
        menuCell.menuIcon.image = UIImage(named: menuIcons[indexPath.row])
        
        
        return menuCell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch(indexPath.row){
            case 0:
            // "Dashboard"
                let mainPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DashboardTabBarController") as! DashboardTabBarController
                let mainPageNav = UINavigationController(rootViewController: mainPageViewController)
                appDelegate.drawerContainer!.centerViewController = mainPageNav
                appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
                break
            case 1:
            // , "Profile"
                let profileViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
                let ProfileNav = UINavigationController(rootViewController: profileViewController)
                //let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.drawerContainer!.centerViewController = ProfileNav
                appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
                break
            case 2:
            //, "Schedule", 
                let scheduleViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ScheduleViewController") as! ScheduleViewController
                let ScheduleNav = UINavigationController(rootViewController: scheduleViewController)
               // let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.drawerContainer!.centerViewController = ScheduleNav
                appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
                break
            case 3:
            // "My pay"
                let MyPayViewController = self.storyboard?.instantiateViewControllerWithIdentifier("myPayViewController") as! myPayViewController
                let myPayNav = UINavigationController(rootViewController: MyPayViewController)
               // let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.drawerContainer!.centerViewController = myPayNav
                appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
                break
            case 4:
            // , "Settings"
                let settingsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
                let settingsNav = UINavigationController(rootViewController: settingsViewController)
              //  let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.drawerContainer!.centerViewController = settingsNav
                appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
                break
            case 5:
            // , "My card", 
                let myCardViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MyCardViewController") as! MyCardViewController
                let myCardNav = UINavigationController(rootViewController: myCardViewController)
              //  let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.drawerContainer!.centerViewController = myCardNav
                appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
                break
            case 6:
            // "Ratings", 
                let ratingsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RatingsViewController") as! RatingsViewController
                let ratingsNav = UINavigationController(rootViewController: ratingsViewController)
              //  let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.drawerContainer!.centerViewController = ratingsNav
                appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
                break
            case 7:
            // "Log Out"
//                let mainPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainPageViewController") as! MainPageViewController
//                let mainPageNav = UINavigationController(rootViewController: mainPageViewController)
//             //   let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                appDelegate.drawerContainer!.centerViewController = mainPageNav
//                appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
                var refreshAlert = UIAlertController(title: "Log out", message: "This action is irriversable. Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
                    
                    self.userDefaults.setObject(nil, forKey: "user_name")
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let vc = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
//                    self.presentViewController(vc, animated: true, completion: nil)
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                }))
                
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                    print("Canceled")
                }))
                presentViewController(refreshAlert, animated: true, completion: nil)
                

                break

            default:
            // do something or nothing
                break
            
        }
           }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
