//
//  AvailabilityViewController.swift
//  VFix_Expert
//
//  Created by Noureddine Youssfi on 4/19/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit

class AvailabilityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableview: UITableView!
    var days: [String] = ["Sunday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var selectedIndexPath: NSIndexPath?
    var dayNums: [Int] = []
    var sortedDayNums: [Int] = []
    var todayIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
//        
//        dayNums.removeAll()
//        sortedDayNums.removeAll()
//        for day in days{
////            print((get(.Next, day)))
////            dayNums.append(Int(convertDateFormater(String(get(.Next, day))))!)
////            print(convertDateFormater(String(get(.Next, day))))
//            print(convertDateFormater2(String(get(.Next, day))))
//        }
        print(days[getDayOfWeek()!])
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("availabilityCell", forIndexPath: indexPath) as! availabilityCell
        cell.dayOfWeekLabel.text = days[indexPath.row]
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath{
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        var indexPaths: Array<NSIndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0{
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! availabilityCell).watchFrameChanges()
    }
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! availabilityCell).ignoreFrameChanges()
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == selectedIndexPath{
            return availabilityCell.expandedHeight
        } else {
            return availabilityCell.defaultHeight
        }
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    func getWeekDaysInEnglish() -> [String] {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        calendar.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    enum SearchDirection {
        case Next
        case Previous
        
        var calendarOptions: NSCalendarOptions {
            switch self {
            case .Next:
                return .MatchNextTime
            case .Previous:
                return [.SearchBackwards, .MatchNextTime]
            }
        }
    }
    func get(direction: SearchDirection, _ dayName: String, considerToday consider: Bool = false) -> NSDate {
        let weekdaysName = getWeekDaysInEnglish()
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let nextWeekDayIndex = weekdaysName.indexOf(dayName)! + 1 // weekday is in form 1 ... 7 where as index is 0 ... 6
        
        let today = NSDate()
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        if consider && calendar.component(.Weekday, fromDate: today) == nextWeekDayIndex {
            return today
        }
        
        let nextDateComponent = NSDateComponents()
        nextDateComponent.weekday = nextWeekDayIndex
        
        
        let date = calendar.nextDateAfterDate(today, matchingComponents: nextDateComponent, options: direction.calendarOptions)
        return date!
    }
    func convertDateFormater(date: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        guard let date = dateFormatter.dateFromString(date) else {
            print("no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let timeStamp = dateFormatter.stringFromDate(date)
        
        return timeStamp
    }
    func convertDateFormater2(date: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        guard let date = dateFormatter.dateFromString(date) else {
            print("no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "EEEE dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let timeStamp = dateFormatter.stringFromDate(date)
        
        return timeStamp
    }
    func getDayOfWeek()->Int? {
        let todayDate = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let myComponents = myCalendar?.components(.NSWeekdayCalendarUnit, fromDate: todayDate)
        let weekDay = myComponents?.weekday
        return weekDay
    }
    @IBAction func submitButtonPressed(sender: AnyObject) {
        var refreshAlert = UIAlertController(title: "Successful submission.", message: "Your availability time has been set!", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
//            self.securityAnimationWithDuration(0.7)
          self.navigationController?.popViewControllerAnimated(true)
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
