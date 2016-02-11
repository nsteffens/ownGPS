//
//  ViewController.swift
//  pushToServer
//
//  Created by your Friend on 09.02.16.
//  Copyright © 2016 my fingertips. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    
    var SERVERURL:String?;
    //var SERVERURL = "http://192.168.0.21/github.php";
    var locationManager:CLLocationManager!;     //Implizit unwrapped!
    var lastLoc:CLLocationCoordinate2D?;
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
            
            lastLoc = locations.last!.coordinate
    }
    
    
    @IBAction func pushLocationButtonPressed(sender: UIButton) {
        
        if(SERVERURL == nil){
            self.statusMessageLabel.text = "Insert a URL first!"
            return;
        }
        
        if(lastLoc != nil){
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
    
    
    func pushToServer(location: CLLocationCoordinate2D) {

            /**
             My API for my reddit buddy.
             POST to var SERVERURL
             */

        
        // Get current Date
        
        let date = NSDate();
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        let dateString = formatter.stringFromDate(date)
        
        
            let urlParams = [
                "lon": String(location.longitude),
                "lat": String(location.latitude),
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
    
    func currentTimeMillis() -> Int64{
        let nowDouble = NSDate().timeIntervalSince1970
        return Int64(nowDouble*1000)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


   
}

