//
//  ScheduleViewController.swift
//  VFix_Expert
//
//  Created by Noureddine Youssfi on 3/26/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import MMDrawerController

class ScheduleViewController: UIViewController {

    @IBOutlet weak var nextJobView: UIView!
    @IBOutlet weak var nexJobDate: UILabel!
    @IBOutlet weak var nextJobCity: UILabel!
    @IBOutlet weak var nextJobTime: UILabel!
    @IBOutlet weak var setAvView: UIView!
    @IBOutlet weak var annouce1View: UIView!
    @IBOutlet weak var annouce2View: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
//        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//        navigationController?.navigationBar.setTitleVerticalPositionAdjustment(CGFloat(7), forBarMetrics: UIBarMetrics.Default)
//        navigationController?.navigationBar.topItem?.title = "Dashboard"
//        navigationController?.navigationBar.
        
        // Do any additional setup after loading the view.
        for view in self.view.subviews {
            if (view.frame.height > 25){
                view.layer.shadowColor = UIColor.darkGrayColor().CGColor
                view.layer.shadowOffset = CGSizeMake(2, 2);
                view.layer.shadowOpacity = 0.5;
                view.layer.shadowRadius = 1.0;
                view.layer.masksToBounds = false
                view.layer.cornerRadius = 5
            }
        }
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
        self.presentViewController(navController, animated:true, completion: nil)    }
    
    @IBAction func referalButtonClicked(sender: AnyObject) {
        referFunction()
//        UIView.animateWithDuration(0.1, animations: {
//            self.annouce2View.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(1.0)
//        })
    }
    func referFunction(){
        let activityViewController = UIActivityViewController(
            activityItems: ["Vfix Expert is a Great App!" as NSString],
            applicationActivities: nil)
        
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    @IBAction func comingSoonPressed(sender: AnyObject) {
        newVersion()
        
        
    }
    func newVersion(){
        var refreshAlert = UIAlertController(title: "Coming soon!", message: "Vfix Expert 2.0 coming soon!", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            //            self.securityAnimationWithDuration(0.7)
//            self.navigationController?.popViewControllerAnimated(true)
        }))
        presentViewController(refreshAlert, animated: true, completion: nil)
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
