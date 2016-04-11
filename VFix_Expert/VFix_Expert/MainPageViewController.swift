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

let sessionToken = "22719873bdbb43cf0cc7f77d6e857e9e"
var endPoint = "companies/13772899/appointments"
let APIKey = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
let baseUrl = "https://www.agendize.com/api/2.0/scheduling/"


class MainPageViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{

    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 157/255.0, blue: 224/255.0, alpha: 1.0)
//        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.topItem?.title = ""

        
        
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
        

        NetworkRequest(sessionToken, endPoint: endPoint)
        
    }
    
    
    func NetworkRequest(sessionToken: String, endPoint: String) {
        Alamofire.request(.GET, "\(baseUrl)\(endPoint)?apiKey=\(APIKey)&token=\(sessionToken)")
            
            .responseJSON { response in
                print(response)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.topItem?.title = "hi"
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
    
    @IBAction func menuButtonClicked(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
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
