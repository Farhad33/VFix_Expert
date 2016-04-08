//
//  CurrentJobViewController.swift
//  VFix_Expert
//
//  Created by Sukhrobjon Golibboev on 4/7/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit


class CurrentJobViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var serviceType = ["VIRUS REMOVAL", "DIAGNOSTIC AND REPAIR", "ELECTRONIC SETUP", "PC TUNE-UP", "PRINTER SETUP", "DATA BACKUP", "WI FI SOLUTIONS", "PC/MAC SUPPORT"]
    var appoinmentTime = ["9:00", "12:30", "13:25","15:45","18:55","20:00", "21:25","22:45"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return serviceType.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CurrentJobCell", forIndexPath: indexPath) as! CurrentJobCell
        
        cell.serviceLabel.text = serviceType[indexPath.row]
        cell.timeLabel.text = appoinmentTime[indexPath.row]
        
        
        return cell
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
