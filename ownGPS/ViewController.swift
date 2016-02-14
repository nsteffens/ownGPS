//
//  ViewController.swift
//  pushToServer
//
//  Created by Nico Steffens on 09.02.16.
//  Copyright © 2016 Nico Steffens. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData
import Alamofire


class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    
    var SERVERURL:String?;
    //var SERVERURL = "http://192.168.0.21/github.php";
    var locationManager:CLLocationManager!;     //Implizit unwrapped!
//    var lastLoc:CLLocationCoordinate2D?;
    var lastLoc: CLLocation?;
    var lastLocation:NSManagedObject?;
    @IBOutlet weak var pushLocationButton: UIButton!
    @IBOutlet weak var statusMessageLabel: UILabel!
    @IBOutlet weak var serverUrlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        serverUrlTextField.delegate = self //set delegate to self
        locationManager = CLLocationManager()

        // Location Manager Auth
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
            print("LocationStarted");
        }
    }
    
    
    func locationManager(manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]){
            
            lastLoc = locations.last!
    }
    
    
    @IBAction func pushLocationButtonPressed(sender: UIButton) {
        
        if(SERVERURL == nil){
            self.statusMessageLabel.text = "Insert a URL first!"
            return;
        }
        
        if(lastLoc != nil){
            print(lastLoc!);
            pushToServer(lastLoc!);
            
            
        }else{
            self.statusMessageLabel.text = "ERROR: Can't get location."
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        SERVERURL = serverUrlTextField.text!;
        print(serverUrlTextField.text!);
        return true;
    }
    
    
    func pushToServer(location: CLLocation) {

        
        // Get the location date & make it look nice
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        let dateString = formatter.stringFromDate(location.timestamp)
        
        
        //var currentLocation = Location(latitude: location.latitude, longitude: location.longitude, timestamp: date)
        
        // Save it to CoreData
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Location", inManagedObjectContext: managedContext)
        
        let Location = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        Location.setValue(location.coordinate.latitude as Double, forKey: "latitude")
        Location.setValue(location.coordinate.longitude as Double, forKey: "longitude")
        Location.setValue(location.timestamp, forKey: "timestamp")
        
        do {
            try managedContext.save()
            locations.append(Location)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        
            let urlParams = [
                "lon": String(location.coordinate.longitude),
                "lat": String(location.coordinate.latitude),
                 "timestamp" :  String(dateString)
            ]
        
        // Fetch Request
        Alamofire.request(.GET, SERVERURL!, parameters: urlParams)
            .validate(statusCode: 200..<300)
            .responseString { response in
                if (response.result.error == nil) {
                    if(response.result.value == "success"){
                        self.statusMessageLabel.text = "Success!";
                    }
                    debugPrint("HTTP Response Body: \(response.data)")
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
    
    }

    
    
    override func viewWillDisappear(animated: Bool){
        // energy saving
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
}

