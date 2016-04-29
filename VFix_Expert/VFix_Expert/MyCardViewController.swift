//
//  MyCardViewController.swift
//  VFix_Expert
//
//  Created by Noureddine Youssfi on 3/26/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import MMDrawerController

class MyCardViewController: UIViewController {

    
    @IBOutlet weak var delightNum: UITextField!
    @IBOutlet weak var lastFour: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
//        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    @IBAction func menuButtonTapped(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }

    @IBAction func onSupportClicked(sender: AnyObject) {
        let suppVC = self.storyboard!.instantiateViewControllerWithIdentifier("SupportViewController") as! SupportViewController
        let navController = UINavigationController(rootViewController: suppVC) // Creating a navigation controller with VC1 at the root of the navigation stack.
        self.presentViewController(navController, animated:true, completion: nil)
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
