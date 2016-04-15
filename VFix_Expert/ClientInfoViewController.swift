//
//  CustomerInfoViewController.swift
//  VFix_Expert
//
//  Created by Sukhrobjon Golibboev on 4/7/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit



class ClientInfoViewController: UIViewController {

    var serviceInfo: String = ""
    var timeInfo: String = ""
    var phoneInfo: String = ""
    var nameInfo: String = ""
    var addressInfo: String = ""
    
    
    
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var serviceTime: UILabel!
    @IBOutlet weak var clientPhone: UILabel!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientAddress: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        serviceType.text = serviceInfo
        serviceTime.text = convertDateFormater(timeInfo)
        clientPhone.text = phoneInfo
        clientName.text = nameInfo
        clientAddress.text = addressInfo

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
