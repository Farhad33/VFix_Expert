//
//  MainPageViewController.swift
//  VFix_Expert
//
//  Created by Noureddine Youssfi on 3/24/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import MMDrawerController
import MapKit
import Alamofire
import CoreLocation
import MessageUI
import TPDMapsApp



// 
class MainPageViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, MFMessageComposeViewControllerDelegate{
    
    
    var serviceInfo: String = ""
    var timeInfo: String = ""
    var phoneInfo: String = ""
    var nameInfo: String = ""
    var addressInfo: String = ""
    var instructionsInfo: String = ""
    var image: UIImage?
    let availableMapsApps = TPDMapsApp.availableMapsAppsSortedByName()
    
    @IBOutlet weak var jobInstructionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var customerAddress: UILabel!
    @IBOutlet weak var customerPhone: UILabel!
    @IBOutlet weak var appointmentTime: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var noInstructionsView: UIView!
    
    var mapManager = MapManager()
    var locationManager: CLLocationManager!
    var def: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.synchronize()
        let defaultMapValue = NSUserDefaults.standardUserDefaults().integerForKey("default_map")
        def = defaultMapValue
        print("\(defaultMapValue) is def map")
        serviceType.text = serviceInfo
        serviceType.textColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 224/255.0, alpha: 1.0)
        customerName.text = nameInfo
        customerPhone.text = phoneInfo
        customerAddress.text = addressInfo
        appointmentTime.text = timeInfo
        bottomView.hidden = false
        noInstructionsView.hidden = true
//        instructionsInfo = "some stuff"
        instructionsTextView.text = instructionsInfo
        if (instructionsInfo == ""){
//            jobInstructionLabel.hidden = true
//            bottomView.center.y = 495
            bottomView.hidden = true
            noInstructionsView.hidden = false
            
        } else {
//            bottomView.center.y = 420
            bottomView.hidden = false
            noInstructionsView.hidden = true
        }
        
        instructionsTextView.flashScrollIndicators()
        
        topView.layer.shadowColor = UIColor.blackColor().CGColor
        topView.layer.shadowOpacity = 1
        topView.layer.shadowOffset = CGSizeZero
        topView.layer.shadowRadius = 5
        
        bottomView.layer.shadowColor = UIColor.blackColor().CGColor
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowOffset = CGSizeZero
        bottomView.layer.shadowRadius = 5
        
        noInstructionsView.layer.shadowColor = UIColor.blackColor().CGColor
        noInstructionsView.layer.shadowOpacity = 1
        noInstructionsView.layer.shadowOffset = CGSizeZero
        noInstructionsView.layer.shadowRadius = 5

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 224/255.0, alpha: 1.0)

        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.topItem?.title = ""
        
        print("\(defaultMapValue) is def map")
        
        // ================ START ===============
        self.mapView?.delegate = self
        self.mapView!.showsUserLocation = true
        // ================ END ===============
        usingAppleButtonPressed()
        removeAllPlacemarkFromMap(shouldRemoveUserLocation: false)
    }
    
     // ================ START ===============
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 224/255.0, alpha: 1.0)
            polylineRenderer.lineWidth = 5
            print("done")
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
    
    func usingAppleButtonPressed(){
        let destination = addressInfo
//        guard let letdestination = destination where !letdestination.isEmpty else {
//            print("enter to and from")
//            return
//        }
        
        self.view.endEditing(true)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        // locationManager.locationServicesEnabled
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        if (locationManager.respondsToSelector(Selector("requestWhenInUseAuthorization"))) {
            //locationManager.requestAlwaysAuthorization() // add in plist NSLocationAlwaysUsageDescription
            locationManager.requestWhenInUseAuthorization() // add in plist NSLocationWhenInUseUsageDescription
        }
    }
    
    func getDirectionsUsingApple() {
        let destination = addressInfo
        mapManager.directionsFromCurrentLocation(to: destination) { (route, directionInformation, boundingRegion, error) -> () in
            if (error != nil) {
                print(error!)
            }
            else {
                if let web = self.mapView {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.removeAllPlacemarkFromMap(shouldRemoveUserLocation: true)
                        web.addOverlay(route!)
                        

                        //
                        if let first = self.mapView.overlays.first {
                            let rect = self.mapView.overlays.reduce(first.boundingMapRect, combine: {MKMapRectUnion($0, $1.boundingMapRect)})
                            self.mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 150.0, left: 50.0, bottom: 150.0, right: 50.0), animated: true)
                        }
//                        web.setVisibleMapRect(boundingRegion!, animated: true)
                        
                        
                    }
                }
            }
        }
    }
    func locationManager(manager: CLLocationManager,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var hasAuthorised = false
        var locationStatus:NSString = ""
        switch status {
        case CLAuthorizationStatus.Restricted:
            locationStatus = "Restricted Access"
        case CLAuthorizationStatus.Denied:
            locationStatus = "Denied access"
        case CLAuthorizationStatus.NotDetermined:
            locationStatus = "Not determined"
        default:
            locationStatus = "Allowed access"
            hasAuthorised = true
        }
        
        if(hasAuthorised == true) {
            getDirectionsUsingApple()
        }
        else {
            print("locationStatus \(locationStatus)")
        }
    }
    
    func removeAllPlacemarkFromMap(shouldRemoveUserLocation shouldRemoveUserLocation:Bool){
        if let mapView = self.mapView {
            for annotation in mapView.annotations{
                if shouldRemoveUserLocation {
                    if annotation as? MKUserLocation !=  mapView.userLocation {
//                        mapView.removeAnnotation(annotation as MKAnnotation)
                    var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(service)
                    
                        if (annotationView == nil) {
                            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: service)
                        }
                        else {
                            annotationView!.annotation = annotation
                        }
                        annotationView!.image = image
                }
            }
            }}
    }

//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        let identifier = "customAnnotationView"
//        
//        // custom image annotation
//        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
//        if (annotationView == nil) {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//        }
//        else {
//            annotationView!.annotation = annotation
//        }
//        annotationView!.image = image
//        
//        return annotationView
//    }
    // ================ END ===============
    
 
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.navigationController?.navigationBarHidden = true
        self.tabBarController?.tabBar.hidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.navigationController?.navigationBarHidden = false
        self.tabBarController?.tabBar.hidden = false
    }
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }

    @IBAction func onCallClicked(sender: AnyObject) {
        contactActionSheet()
    }
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResultCancelled.rawValue:
            print("Message was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultFailed.rawValue:
            print("Message failed")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultSent.rawValue:
            print("Message was sent")
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            break;
        }
    }
    
    func contactActionSheet(){
        let optionMenu = UIAlertController(title: nil, message: "Contact \(nameInfo)", preferredStyle: .ActionSheet)
        
        // 2
        let callAction = UIAlertAction(title: "Call \(nameInfo)", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.callNumber(self.phoneInfo)
        })
        let messageAction = UIAlertAction(title: "Message \(nameInfo)", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            var messageVC = MFMessageComposeViewController()
            
            messageVC.body = ""
            messageVC.recipients = [self.phoneInfo]
            messageVC.messageComposeDelegate = self;
            
            self.presentViewController(messageVC, animated: false, completion: nil)
            
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        // 4
        optionMenu.addAction(callAction)
        optionMenu.addAction(messageAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func navigateButton(sender: AnyObject) {
        let app = availableMapsApps![def!] as! TPDMapsApp
        app.openWithQuery(addressInfo)
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
