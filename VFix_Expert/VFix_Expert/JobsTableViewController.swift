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
import ARSLineProgress
/*
var sessionToken = "22719873bdbb43cf0cc7f77d6e857e9e"
var url = "companies/13772899/appointments"
let APIKey = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
let baseUrl = "https://www.agendize.com/api/2.0/scheduling/"
*/
private var Token = "22719873bdbb43cf0cc7f77d6e857e9e"
private var Key = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
private var BaseUrl = "https://www.agendize.com/api/2.0/scheduling/companies/13772899/appointments?staffId="
private var Id = "13772906"

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
var serviceIcon: [String] = ["DataRecovery.png", "Diagnostic-and-Repair.png", "Electronic-Setup.png", "PC-TuneUp.png", "Printer-Setup.png", "Virus-Removal.png", "Wi-Fi-Solutions.png"]
var serviceImage: UIImage?

class JobsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var app = UIApplication.sharedApplication()
    override func viewDidLoad() {
        

        
        super.viewDidLoad()
        //self.app.beginIgnoringInteractionEvents()
        NetworkRequest()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    /*
     button.backgroundColor = UIColor.clearColor()
     button.layer.cornerRadius = 5
     button.layer.borderWidth = 1
     button.layer.borderColor = UIColor.blackColor().CGColor
     */
    
    override func viewWillDisappear(animated: Bool) {
//        appointments.removeAll()
    }
    override func viewWillAppear(animated: Bool) {
//        NetworkRequest()
    }
    
    func NetworkRequest() {
        if ARSLineProgress.shown { return }
        ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
            print("Showed with completion block")
        }
        
        Alamofire.request(.GET, "\(BaseUrl)\(Id)&token=\(Token)&apiKey=\(Key)")
            .responseJSON { response in
                appointments.removeAll()
                if response.result.isSuccess{
                    print("success")
                    if let value = response.result.value {
                        let values = JSON(value)
                        let data = values["items"]
                        print(data)
                        for (_, j) in data {
                            if Id == j["staff"]["id"].stringValue{
                                appointments.append(j)
                            }
                        }
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                            ARSLineProgress.hideWithCompletionBlock({ () -> Void in
                                print("Hidden with completion block")
                            })
                        })
                        ARSLineProgress.showSuccess()
                        self.view.userInteractionEnabled = true
                        //self.app.endIgnoringInteractionEvents()
                    }else {
                        print("nothing yet")
                        ARSLineProgress.showFail()
                        //self.app.beginIgnoringInteractionEvents()
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
    func convertDateFormater2(date: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        guard let date = dateFormatter.dateFromString(date) else {
            print("no date from string")
            return ""
        }
        
//        dateFormatter.dateFormat = "HH:mm a"
        dateFormatter.dateStyle = .LongStyle

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
        cell.appointmentDate.text = convertDateFormater2(String(appointments[indexPath.row]["start"]["dateTime"]))
        let serviceCheck = String(appointments[indexPath.row]["service"]["id"])
        switch serviceCheck {
        // Data BackUp
        case "23808507":
            cell.serviceIcon.image = UIImage(named: serviceIcon[0])
            serviceImage = UIImage(named: serviceIcon[0])
            break
        // Diagnostic and repair
        case "23808496":
            cell.serviceIcon.image = UIImage(named: serviceIcon[1])
            serviceImage = UIImage(named: serviceIcon[1])
            break
        // Electronic Setup
        case "3808495":
            cell.serviceIcon.image = UIImage(named: serviceIcon[2])
            serviceImage = UIImage(named: serviceIcon[2])
            break
        // PC-TuneUp
        case "13772901":
            cell.serviceIcon.image = UIImage(named: serviceIcon[3])
            serviceImage = UIImage(named: serviceIcon[3])
            break
        // Printer Setup
        case "13772904":
            cell.serviceIcon.image = UIImage(named: serviceIcon[4])
            serviceImage = UIImage(named: serviceIcon[4])
            break
        // Virus Removal
        case "13772900":
            cell.serviceIcon.image = UIImage(named: serviceIcon[5])
            serviceImage = UIImage(named: serviceIcon[5])
            break
        // Wi-Fi-Solutions
        case "23808512":
            cell.serviceIcon.image = UIImage(named: serviceIcon[6])
            serviceImage = UIImage(named: serviceIcon[6])
            break
        // PC/Mac Support
        case "23808513":
            cell.serviceIcon.image = UIImage(named: serviceIcon[7])
            serviceImage = UIImage(named: serviceIcon[7])
            break
        default:
            cell.serviceIcon.image = UIImage(named: serviceIcon[0])
            serviceImage = UIImage(named: serviceIcon[0])
        }
        
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
        detailViewController.image = serviceImage
    }
    
    @IBAction func onSupportClicked(sender: AnyObject) {
        let suppVC = self.storyboard!.instantiateViewControllerWithIdentifier("SupportViewController") as! SupportViewController
        let navController = UINavigationController(rootViewController: suppVC) // Creating a navigation controller with VC1 at the root of the navigation stack.
        self.presentViewController(navController, animated:true, completion: nil)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("SupportViewController") as! SupportViewController
//        self.presentViewController(vc, animated: true, completion: nil)
    }

}
