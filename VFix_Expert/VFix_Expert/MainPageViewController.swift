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

//let sessionToken = "22719873bdbb43cf0cc7f77d6e857e9e"
//var endPoint = "companies/13772899/appointments"
//let APIKey = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
//let baseUrl = "https://www.agendize.com/api/2.0/scheduling/"
let defaultMapValue = NSUserDefaults.standardUserDefaults().integerForKey("default_map")

class MainPageViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{

    var serviceInfo: String = ""
    var timeInfo: String = ""
    var phoneInfo: String = ""
    var nameInfo: String = ""
    var addressInfo: String = ""
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager : CLLocationManager!
    
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var customerAddress: UILabel!
    @IBOutlet weak var customerPhone: UILabel!
    @IBOutlet weak var appointmentTime: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceType.text = serviceInfo
        serviceType.textColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 224/255.0, alpha: 1.0)
        customerName.text = nameInfo
        customerPhone.text = phoneInfo
        customerAddress.text = addressInfo
        appointmentTime.text = timeInfo
        instructionsTextView.flashScrollIndicators() 
        
//        self.navigationController?.navigationBar.backItem?.title = "Back"
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 224/255.0, alpha: 1.0)
//        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.topItem?.title = ""
        
        print("\(defaultMapValue) is def map")
        
        let location: String = "50 phelan ave sanfrancisco CA"
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(location,completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if (placemarks?.count > 0) {
                let topResult: CLPlacemark = (placemarks?[0])!
                let placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                var region: MKCoordinateRegion = self.mapView.region
                
                region.center.latitude = (placemark.location?.coordinate.latitude)!
                region.center.longitude = (placemark.location?.coordinate.longitude)!
                
                region.span = MKCoordinateSpanMake(0.5, 0.5)
                
                self.mapView.setRegion(region, animated: true)
                self.mapView.addAnnotation(placemark)
            }
        })
        
        let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        // zoomEnabled, scrollEnabled, pitchEnabled, rotateEnabled <================= IMPORTANT ================
        goToLocation(centerLocation)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        

//        NetworkRequest(sessionToken, endPoint: endPoint)
        
    }
    
    
//    func NetworkRequest(sessionToken: String, endPoint: String) {
//        Alamofire.request(.GET, "\(baseUrl)\(endPoint)?apiKey=\(APIKey)&token=\(sessionToken)")
//            
//            .responseJSON { response in
//                print(response)
//        }
//        
//    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        print("\(defaultMapValue) is def map")
        self.tabBarController?.navigationController?.navigationBarHidden = true
        self.tabBarController?.tabBar.hidden = true
//        self.navigationController?.navigationBar.topItem?.title = "hi"
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.navigationController?.navigationBarHidden = false
        self.tabBarController?.tabBar.hidden = false
    }
    
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "An annotation!"
        mapView.addAnnotation(annotation)
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: false)
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
//    @IBAction func menuButtonClicked(sender: AnyObject) {
//        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
//    }

    @IBAction func onCallClicked(sender: AnyObject) {
        let phone = customerPhone.text
        let url:NSURL = NSURL(string:phone!)!
        UIApplication.sharedApplication().openURL(url);
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
