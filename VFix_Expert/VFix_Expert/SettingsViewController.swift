//
//  SettingsViewController.swift
//  VFix_Expert
//
//  Created by Noureddine Youssfi on 3/26/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import MMDrawerController
import TPDMapsApp

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var hiddencell: Int = 0
    let availableMapsApps = TPDMapsApp.availableMapsAppsSortedByName()
    var mapsIcons: [String] = ["Dashboard.png", "Profile.png", "Schedule.png"]
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        
//          navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        tableview.delegate = self
        tableview.dataSource = self
        tableview.scrollEnabled = false
        
        
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("defaultMapsCell", forIndexPath: indexPath) as! defaultMapsCell
        let app = availableMapsApps![indexPath.row] as! TPDMapsApp
        cell.mapsAppImage.image = UIImage(named: mapsIcons[indexPath.row])
        cell.mapsAppName.text = app.name
//        cell.mapsAppName.enabled = app.installed
        
        if (app.installed == false) {
           tableView.rowHeight = 0
        }else {
            tableView.rowHeight = 55
        }
        return cell
        
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle  {
        return .LightContent
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableMapsApps.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.dequeueReusableCellWithIdentifier("defaultMapsCell", forIndexPath: indexPath) as! defaultMapsCell
        let app = availableMapsApps![indexPath.row] as! TPDMapsApp
        let chosenMap: defaultMaps = defaultMaps()
        switch(indexPath.row){
        case 0:
//            cell.checkBoxView.setOn(true, animated: true)
//            app.openWithQuery("100 Van Ness Ave San Francisco CA 94102");
            chosenMap.setDefault(app)
            print(indexPath.row)
            break
        case 1:
//            cell.checkBoxView.setOn(true, animated: true)
//            app.openWithQuery("100 Van Ness Ave San Francisco CA 94102");
            chosenMap.setDefault(app)
            print(indexPath.row)
            break
        case 2:
//            cell.checkBoxView.setOn(true, animated: true)
//            app.openWithQuery("100 Van Ness Ave San Francisco CA 94102");
            chosenMap.setDefault(app)
            print(indexPath.row)
            break
        default:
            print(indexPath.row)
        }
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
