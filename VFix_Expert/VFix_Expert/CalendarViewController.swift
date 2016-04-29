//
//  CalendarViewController.swift
//  VFix_Expert
//
//  Created by Dustyn August on 3/10/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import CalendarLib
import EventKitUI
import EventKit
import Alamofire
import SwiftyJSON
import ARSLineProgress


private var calendarToken = "22719873bdbb43cf0cc7f77d6e857e9e"
private var calendarKey = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
private var calendarBaseUrl = "http://www.agendize.com/api/2.0/scheduling/companies/13772899/appointments?"
private var calendarId = "13772906"

private var agendizeStartTime: String!


var calendarJson: JSON!
var calendarService: String!
var calendarAppointmentStartTime: String!
var calendarAppointmentEndTime: String!
var calendarAddress: String!
var calendarUserApppointments: Array =  [JSON]()

var calendarAppointmentStartDate: NSDate!
var calendarAppointmentEndDate: NSDate!



class CalendarViewController: MGCDayPlannerViewController {
    
    
    private var selectedService: String?
    private var selectedAppointmentTime: String?
    private var selectedAddress: String?
    private var selectedPhone: String?
    private var selectedClientName: String?
    private var selectedNotes: String?
    var app = UIApplication.sharedApplication()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let agendizeDateFormatter = NSDateFormatter()
        agendizeDateFormatter.timeZone = NSTimeZone(name: "US/Pacific")
        
        agendizeDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        agendizeStartTime = agendizeDateFormatter.stringFromDate(NSDate())
        self.app.beginIgnoringInteractionEvents()
        
        NetworkRequest()
        
        dayPlannerView.numberOfVisibleDays = 4
        dayPlannerView.dateFormat = "eee d"
        dayPlannerView.dayHeaderHeight = 60
        dayPlannerView.canCreateEvents = false
        dayPlannerView.canMoveEvents = false
        dayPlannerView.daySeparatorsColor = UIColor.blackColor()
        dayPlannerView.timeSeparatorsColor = UIColor.blackColor()
        dayPlannerView.tintColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 224/255.0, alpha: 1.0)

        dayPlannerView.currentTimeColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 224/255.0, alpha: 1.0)

        dayPlannerView.eventIndicatorDotColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 224/255.0, alpha: 1.0)

        
    }
    
    // &startDateTime=\(agendizeStartTime)
    func NetworkRequest()  {
        if ARSLineProgress.shown { return }
            ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
            print("Showed with completion block")
            }
                
        Alamofire.request(.GET, "\(calendarBaseUrl)staffId=\(calendarId)&token=\(calendarToken)&apiKey=\(calendarKey)")
            .responseJSON { response in
                
                if response.result.isSuccess{
                    
                    calendarUserApppointments.removeAll()
                    if let value = response.result.value {
                        let json = JSON(value)
                        
                        for (_, i) in json["items"]{
                            
                            let userAppStartString = i["start"]["dateTime"].stringValue
                            
                            let formatter = NSDateFormatter()
                            formatter.timeZone = NSTimeZone(name: "US/Pacific")
                            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                            
                            let userAppStartDate = formatter.dateFromString(userAppStartString)
                            
                            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                            formatter.timeZone = NSTimeZone(name: "UTC")
                            let currentDateString = formatter.stringFromDate(NSDate())
                            
                            let testDateString = "2016-04-21 09:15:00 +0000"
                            let currentDate = formatter.dateFromString(testDateString)
                            
                            if userAppStartDate!.compare(currentDate!) == NSComparisonResult.OrderedDescending
                            {
                                //                                NSLog("date1 after date2");
                                calendarUserApppointments.append(i)
                            } else if userAppStartDate!.compare(currentDate!) == NSComparisonResult.OrderedAscending
                            {
                                //                                NSLog("date1 before date2");
                            } else
                            {
                                //                                NSLog("dates are equal");
                            }
                            
                            self.setupDayPlannerView()
                            
                        }
                    }
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                        ARSLineProgress.hideWithCompletionBlock({ () -> Void in
                            print("Hidden with completion block")
                        })
                    })
                    ARSLineProgress.showSuccess()
                    self.view.userInteractionEnabled = true
                    self.app.endIgnoringInteractionEvents()
                } else {
                    print("Alamofire Fail")
                    ARSLineProgress.showFail()
                    self.app.beginIgnoringInteractionEvents()
                }
        }
        
    }
    
    func setupDayPlannerView() {
        dayPlannerView.scrollToDate(NSDate(), options: MGCDayPlannerScrollType.DateTime, animated: true)
        dayPlannerView.delegate = self
        dayPlannerView.dataSource = self
        dayPlannerView.reloadAllEvents()
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func shouldAutorotate() -> Bool {
        return false
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
    // The following three methods are required methods for the MGCDayPlannerViewDataSource Protocol
    
    // **required**
    // Called 1st
    // Returns the number of events of type MGCEventType at date
    override func dayPlannerView(view: MGCDayPlannerView!, numberOfEventsOfType type: MGCEventType, atDate date: NSDate!) -> Int {
        var numberOfAppointments = 0
        
        let numberofEventsDateFormatter = NSDateFormatter()
        numberofEventsDateFormatter.timeZone = NSTimeZone(name: "US/Pacific")
        
        numberofEventsDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss  Z"
        var numberofEventsDate = numberofEventsDateFormatter.stringFromDate(date)
        
        let numberOfEventsDateArray = numberofEventsDate.componentsSeparatedByString(" ")
        numberofEventsDate = numberOfEventsDateArray[0] //will always be numberOfEventsDateArray[0]
        
        for i in calendarUserApppointments {
            var appointmentDate = i["start"]["dateTime"].stringValue
            numberofEventsDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let appointmentDateArr = appointmentDate.componentsSeparatedByString("T")
            appointmentDate = appointmentDateArr[0] // will always be appointmentDateArr[0]
            
            if (numberofEventsDate == appointmentDate) {
                numberOfAppointments += 1
            }
        }
        
        //        print("date: \(date)")
        //        print("number: \(numberOfAppointments)")
        return numberOfAppointments
    }
    
    //
    // **required**
    // Called 2nd
    // returns an MGCDateRange for MGCEventType at some index or for some date ??
    override func dayPlannerView(view: MGCDayPlannerView!, dateRangeForEventOfType type: MGCEventType, atIndex index: UInt, date: NSDate!) -> MGCDateRange! {
        calendarAppointmentStartTime = calendarUserApppointments[Int(index)]["start"]["dateTime"].stringValue
        calendarAppointmentEndTime  = calendarUserApppointments[Int(index)]["end"]["dateTime"].stringValue
        
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(name: "US/Pacific")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        calendarAppointmentStartDate = formatter.dateFromString(calendarAppointmentStartTime)
        calendarAppointmentEndDate = formatter.dateFromString(calendarAppointmentEndTime)
        
        
        //        print("date: \(date)")
        //        print("appointmentStartTime: \(appointmentStartTime)")
        //        print("appointmentStartDate: \(appointmentStartDate)")
        //        print("appointmentEndTime: \(appointmentEndTime)")
        //        print("appointmentEndDate: \(appointmentEndDate)")
        //        print()
        
        return MGCDateRange(start: calendarAppointmentStartDate, end: calendarAppointmentEndDate)
    }
    
    //
    // **required**
    // Called 3rd
    // returns MGCEventView for MGCEventType at some index or for some date ??
    override func dayPlannerView(view: MGCDayPlannerView!, viewForEventOfType type: MGCEventType, atIndex index: UInt, date: NSDate!) -> MGCEventView! {
        let viewForEventDateFormatter = NSDateFormatter()
        viewForEventDateFormatter.timeZone = NSTimeZone(name: "UTC")
        viewForEventDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss  Z"
        
        var viewForEventDate = viewForEventDateFormatter.stringFromDate(date)
        let eventDateArr = viewForEventDate.componentsSeparatedByString(" ")
        viewForEventDate = eventDateArr[0]
        
        var appointmentDate = calendarUserApppointments[Int(index)]["start"]["dateTime"].stringValue
        viewForEventDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let appointmentDateArr = appointmentDate.componentsSeparatedByString("T")
        appointmentDate = appointmentDateArr[0]
        
        if (appointmentDate == viewForEventDate ) {
            
            let street = calendarUserApppointments[Int(index)]["client"]["address"]["street"].stringValue
            let city = calendarUserApppointments[Int(index)]["client"]["address"]["city"].stringValue
            let state = calendarUserApppointments[Int(index)]["client"]["address"]["state"].stringValue
            let zip = calendarUserApppointments[Int(index)]["client"]["address"]["zipCode"].stringValue
            address = "\(street), \(city), \(state) \(zip)"
            
            let appointmentView = MGCStandardEventView()
            appointmentView.title = calendarUserApppointments[Int(index)]["service"]["name"].stringValue
            appointmentView.font = UIFont(name: "Apple SD Gothic Neo", size: 12)
//            appointmentView.subtitle = address
            appointmentView.color = UIColor(red: 20/255.0, green: 157/255.0, blue: 224/255.0, alpha: 1.0)

            
            
            
            return appointmentView
        }
        return nil
    }
    
    
//    override func dayPlannerView(view: MGCDayPlannerView!, didSelectEventOfType type: MGCEventType, atIndex index: UInt, date: NSDate!) {
//        
//        let selectionFormatter = NSDateFormatter()
//        selectionFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        let selectionDate = selectionFormatter.dateFromString(calendarUserApppointments[Int(index)]["start"]["dateTime"].stringValue)
//        
//        
//        selectionFormatter.timeStyle = .ShortStyle
//        
//        
//        
//        let street = calendarUserApppointments[Int(index)]["client"]["address"]["street"].stringValue
//        let city = calendarUserApppointments[Int(index)]["client"]["address"]["city"].stringValue
//        let state = calendarUserApppointments[Int(index)]["client"]["address"]["state"].stringValue
//        let zip = calendarUserApppointments[Int(index)]["client"]["address"]["zipCode"].stringValue
//        
//        let selectedService = calendarUserApppointments[Int(index)]["service"]["name"].stringValue
//        let selectedClientName = calendarUserApppointments[Int(index)]["client"]["firstName"].stringValue + " " + calendarUserApppointments[Int(index)]["client"]["lastName"].stringValue
//        let selectedAppointmentTime = selectionFormatter.stringFromDate(selectionDate!)
//        let selectedPhone = calendarUserApppointments[Int(index)]["client"]["phone"].stringValue
//        let selectedAddress = "\(street), \(city), \(state) \(zip)"
//        let selectedAppointmentInstructions = calendarUserApppointments[Int(index)]["notes"].stringValue
//        
//        
//        let appointmentView = MGCStandardEventView()
//        appointmentView.title = calendarUserApppointments[Int(index)]["service"]["name"].stringValue
//        appointmentView.subtitle = address
//        
//        // Service type, time and date, address, customer name, phone number
//        
//        print(selectedService)
//        print(selectedClientName)
//        print(selectedAppointmentTime)
//        print(selectedPhone)
//        print(selectedAddress)
//        print(selectedAppointmentInstructions)
//        //        print("selected service: \(appointmentView.title).")
//        //        print("selected addreds: \(appointmentView.subtitle).")
//        
//        
//        self.performSegueWithIdentifier("CalendarToDetailsSegue", sender: self)
//    }
    override func dayPlannerView(view: MGCDayPlannerView!, didSelectEventOfType type: MGCEventType, atIndex index: UInt, date: NSDate!) {
        
        let selectionFormatter = NSDateFormatter()
        selectionFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let selectionDate = selectionFormatter.dateFromString(calendarUserApppointments[Int(index)]["start"]["dateTime"].stringValue)
        
        
        selectionFormatter.timeStyle = .ShortStyle
        
        
        
        let street = calendarUserApppointments[Int(index)]["client"]["address"]["street"].stringValue
        let city = calendarUserApppointments[Int(index)]["client"]["address"]["city"].stringValue
        let state = calendarUserApppointments[Int(index)]["client"]["address"]["state"].stringValue
        let zip = calendarUserApppointments[Int(index)]["client"]["address"]["zipCode"].stringValue
        
        selectedService = calendarUserApppointments[Int(index)]["service"]["name"].stringValue
        selectedClientName = calendarUserApppointments[Int(index)]["client"]["firstName"].stringValue + " " + calendarUserApppointments[Int(index)]["client"]["lastName"].stringValue
        selectedAppointmentTime = selectionFormatter.stringFromDate(selectionDate!)
        selectedPhone = calendarUserApppointments[Int(index)]["client"]["phone"].stringValue
        selectedAddress = "\(street), \(city), \(state) \(zip)"
        selectedNotes = calendarUserApppointments[Int(index)]["notes"].stringValue
        
        
        let appointmentView = MGCStandardEventView()
        appointmentView.title = calendarUserApppointments[Int(index)]["service"]["name"].stringValue
        appointmentView.subtitle = address
        
        // Service type, time and date, address, customer name, phone number
        
        print(selectedService)
        print(selectedClientName)
        print(selectedAppointmentTime)
        print(selectedPhone)
        print(selectedAddress)
        print(selectedNotes)
        //        print("selected service: \(appointmentView.title).")
        //        print("selected addreds: \(appointmentView.subtitle).")
        
        
        
        
        
        self.performSegueWithIdentifier("CalendarToDetailsSegue", sender: self)
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = storyboard.instantiateViewControllerWithIdentifier("MainPageViewController") as! UIViewController
        //        self.presentViewController(vc, animated: true, completion: nil)
    }
    override func dayPlannerView(view: MGCDayPlannerView!, didDeselectEventOfType type: MGCEventType, atIndex index: UInt, date: NSDate!) {
        print("deselected")
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let detailViewController = segue.destinationViewController as! MainPageViewController
        detailViewController.serviceInfo = selectedService!
        detailViewController.timeInfo = selectedAppointmentTime!
        detailViewController.addressInfo = selectedAddress!
        detailViewController.phoneInfo = selectedPhone!
        detailViewController.nameInfo = selectedClientName!
        detailViewController.instructionsInfo = selectedNotes!
    }
    
}


extension NSDate {
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.dateByAddingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: NSTimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.dateByAddingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
  
    
}