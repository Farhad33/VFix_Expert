//
//  JobsTableViewController.swift
//  VFix_Expert
//
//  Created by Dustyn August on 3/10/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var sessionToken = "22719873bdbb43cf0cc7f77d6e857e9e"
var url = "companies/13772899/appointments"
let APIKey = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
let baseUrl = "https://www.agendize.com/api/2.0/scheduling/"
var address: String = ""
var city: String = ""
var state: String = ""
var zip: String = ""
var startTime: String = ""
var service: String = ""


var clientCountry: String = ""
var clientStreet: String = ""
var clientState: String = ""
var clientZip: String = ""
var clientCity: String = ""

var appointments = [JSON]()

var staffID: String = "13772906"

class JobsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NetworkRequest()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func NetworkRequest() {
        Alamofire.request(.GET, "\(baseUrl)\(url)?apiKey=\(APIKey)&token=\(sessionToken)")
            .responseJSON { response in
                if let value = response.result.value {
                    if response.result.isSuccess == true{
                        let json = JSON(value)
                        print(appointments)
                        let response = json["items"]
                        for (_, j) in response {
                            
                            
                            if staffID == j["staff"]["id"].stringValue{
                                appointments.append(j)
                            }
                        }
                        print("after")
                        print(appointments)
                        
                    } else {
                        print("not there yet")
                    }
                    self.tableView.dataSource = self
                    self.tableView.delegate = self
                    self.tableView.reloadData()
                }
        }
    }
    func convertDateFormater(date: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        guard let date = dateFormatter.dateFromString(date) else {
            print("no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "HH:mm a"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let timeStamp = dateFormatter.stringFromDate(date)
        
        return timeStamp
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("JobTableViewCell", forIndexPath: indexPath) as! JobTableViewCell

        
        cell.serviceTypeLabel.text = String(appointments[indexPath.row]["service"]["name"])
        cell.appointmentTime.text = convertDateFormater(String(appointments[indexPath.row]["start"]["dateTime"]))
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        
        let appointment = String(appointments[indexPath!.row]["service"]["name"])
        let appointment_time = convertDateFormater(String(appointments[indexPath!.row]["start"]["dateTime"]))
        
        
         clientStreet = String(appointments[indexPath!.row]["client"]["address"]["street"])
         clientState = String(appointments[indexPath!.row]["client"]["address"]["state"])
         clientZip = String(appointments[indexPath!.row]["client"]["address"]["zipCode"])
         clientCity = String(appointments[indexPath!.row]["client"]["address"]["city"])
         
 
        
        let client_phone = String(appointments[indexPath!.row]["client"]["phone"])
        let client_address = clientStreet + " " + clientCity + " " + clientState + " " + clientZip
        let client_name = ("\(String(appointments[indexPath!.row]["client"]["lastName"])) \(String(appointments[indexPath!.row]["client"]["firstName"]))")
        let detailViewController = segue.destinationViewController as! MainPageViewController
        detailViewController.serviceInfo = appointment
        detailViewController.timeInfo = appointment_time
        detailViewController.addressInfo = client_address
        detailViewController.phoneInfo = client_phone
        detailViewController.nameInfo = client_name
    }
    
    @IBAction func onSupportClicked(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SupportViewController") as! SupportViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }

}
