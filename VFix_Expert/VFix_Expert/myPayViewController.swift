//
//  myPayViewController.swift
//  VFix_Expert
//
//  Created by Noureddine Youssfi on 3/26/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import MMDrawerController

class myPayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var totalWeeklyPayment: UILabel!
    var tableView: UITableView = UITableView()
    var items: [String] = ["This Month:", "This week:", "Last week:", "Week before:"]
    var money: [String] = ["$ 100.00", "$ 200.00", "$ 300.00"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
//        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        addMonthView(items, money: money)
        topView.layer.shadowColor = UIColor.darkGrayColor().CGColor
        topView.layer.shadowOffset = CGSizeMake(2, 2);
        topView.layer.shadowOpacity = 1;
        topView.layer.shadowRadius = 1.0;
        topView.layer.masksToBounds = false
        
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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        
        if (indexPath.row < 1){
            cell.textLabel?.text = self.items[indexPath.row]
            cell.textLabel?.textColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
            cell.textLabel?.font = cell.textLabel?.font.fontWithSize(17)
        }else {
            cell.textLabel?.text = self.items[indexPath.row] + " " + self.money[indexPath.row - 1]
            cell.textLabel?.font = cell.textLabel?.font.fontWithSize(13)
            cell.textLabel?.textAlignment = NSTextAlignment.Center
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func addMonthView(months: [String], money: [String]){
        tableView.frame = CGRectMake(0, 50, 305, 200);
        tableView.center = self.view.center
        tableView.frame.origin.y = topView.frame.height + (topView.frame.height / 2)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = false
        tableView.userInteractionEnabled = false
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.borderColor = UIColor .grayColor().CGColor
        tableView.layer.borderWidth = 0.5
        tableView.layer.cornerRadius = 5
        tableView.layer.masksToBounds = true
        
        self.view.addSubview(tableView)
    }
    
    @IBAction func onSupportClicked(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SupportViewController") as! SupportViewController
        self.presentViewController(vc, animated: true, completion: nil)
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
