//
//  CurrentJobViewController.swift
//  VFix_Expert
//
//  Created by Sukhrobjon Golibboev on 4/7/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var sessionToken = "22719873bdbb43cf0cc7f77d6e857e9e"
var url = "companies/13772899/appointments"
let APIKey = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
let baseUrl = "https://www.agendize.com/api/2.0/scheduling/"
var tableData: [String] = []
var address: String = ""
var city: String = ""
var state: String = ""
var zip: String = ""
var startTime: String = ""
var service: String = ""
var responseCount: Int = 0

var clientName: String = ""
var clientCountry: String = ""
var clientStreet: String = ""
var clientState: String = ""
var clientZip: String = ""
var clientCity: String = ""
var clientOtherStreet: String = ""
var clientEmail: String = ""
var clientPhone: String = ""
var servicePrice: String = ""


class CurrentJobViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // var serviceType = ["VIRUS REMOVAL", "DIAGNOSTIC AND REPAIR", "ELECTRONIC SETUP", "PC TUNE-UP", "PRINTER SETUP", "DATA BACKUP", "WI FI SOLUTIONS", "PC/MAC SUPPORT"]
    //var appoinmentTime = ["9:00", "12:30", "13:25","15:45","18:55","20:00", "21:25","22:45"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("inside viewdidload")
        
        NetworkRequest()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        print("inside viewwillappear")
        
    }
    
    func NetworkRequest() {
        Alamofire.request(.GET, "\(baseUrl)\(url)?apiKey=\(APIKey)&token=\(sessionToken)")
            
            .responseJSON { response in
                if let value = response.result.value {
                    if response.result.isSuccess == true{
                        let json = JSON(value)
                        let response = json["items"]
                        responseCount = response.count
                        print(response)
                        //                    print(address)
                        
                        address = String(response[0]["form"][0]["value"])
                        city = String(response[0]["form"][1]["value"])
                        state = String(response[0]["form"][2]["value"])
                        zip = String(response[0]["form"][3]["value"])
                        startTime = String(response[0]["start"]["dateTime"])
                        service = String(response[0]["service"]["name"])
                        clientName = ("\(String(response[0]["client"]["lastName"])) \(String(response[0]["client"]["firstName"]))")
                        clientStreet = String(response[0]["client"]["address"]["street"])
                        clientState = String(response[0]["client"]["address"]["state"])
                        clientZip = String(response[0]["client"]["address"]["zipCode"])
                        clientCity = String(response[0]["client"]["address"]["city"])
                        clientOtherStreet = String(response[0]["client"]["address"]["otherStreet"])
                        clientEmail = String(response[0]["client"]["email"])
                        clientPhone = String(response[0]["client"]["phone"])
                        servicePrice = String(response[0]["price"])
                        
                        print(clientName)
                        print(clientStreet)
                        print(clientState)
                        print(clientZip)
                        print(clientCity)
                        print(clientOtherStreet)
                        print(clientEmail)
                        print(clientPhone)
                        print(servicePrice)
         
                    } else {
                        print("not there yet")
                    }
                    self.tableView.dataSource = self
                    self.tableView.delegate = self
                    self.tableView.reloadData()
                }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableData.count
        return responseCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CurrentJobCell", forIndexPath: indexPath) as! CurrentJobCell
        
        
        cell.serviceLabel.text = service
        cell.timeLabel.text = startTime
       
        return cell
    }
    
   
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let appointment = service
        let appointment_time = startTime
        
        /*
         clientStreet = String(response[0]["client"]["address"]["street"])
         clientState = String(response[0]["client"]["address"]["state"])
         clientZip = String(response[0]["client"]["address"]["zipCode"])
         clientCity = String(response[0]["client"]["address"]["city"])

         */
        
        let client_phone = clientPhone
        let client_address = clientStreet + " " + clientCity + " " + clientState + " " + clientZip
        //let address =
        let detailViewController = segue.destinationViewController as! ClientInfoViewController
        detailViewController.serviceInfo = appointment
        detailViewController.timeInfo = appointment_time
        detailViewController.addressInfo = client_address
        detailViewController.phoneInfo = client_phone
        
     }
 
    
}
