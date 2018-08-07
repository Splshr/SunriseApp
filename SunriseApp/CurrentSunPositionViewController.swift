//
//  ViewController.swift
//  Sunset
//
//  Created by Dmytro Khrystych on 8/3/18.
//  Copyright © 2018 WonderDev. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentSunPositionViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var sunsetTimeLabel: UILabel!
    @IBOutlet weak var solarNoonTimeLabel: UILabel!
    @IBOutlet weak var dayLengthLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    let model = Model()
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if (error != nil) {
                print("Error in reverse geocoding")
            } else {
                if let place = placemark?[0] {
                    self.updateSunFeaturesForLocation(location: place.locality!)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityLabel.text = ""
        sunriseTimeLabel.text = ""
        sunsetTimeLabel.text = ""
        solarNoonTimeLabel.text = ""
        dayLengthLabel.text = ""
        
        searchBar.delegate = self
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text {
            updateSunFeaturesForLocation(location: locationString)
        }
    }
    
    
    func updateSunFeaturesForLocation (location:String) {
        
        searchBar.text = ""
        
        cityLabel.text = location
        
        CLGeocoder().geocodeAddressString(location) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                if let location = placemarks?.first?.location {
                    
                    self.model.forecast(withLocation: location.coordinate, completion: { (currentSunPos) in
                        if let currentSunPos = currentSunPos {
                            DispatchQueue.main.async {
                                
                                if let sunrise = currentSunPos.sunrise {
                                    self.sunriseTimeLabel.text = "Sunrise: \(sunrise) UTC"
                                } else {
                                    self.sunriseTimeLabel.text = "No data availible"
                                }
                                
                                if let sunset = currentSunPos.sunset {
                                    self.sunsetTimeLabel.text = "Sunset: \(sunset) UTC"
                                } else {
                                    self.sunsetTimeLabel.text = "No data availible"
                                }
                                
                                if let solar_noon = currentSunPos.solar_noon {
                                    self.solarNoonTimeLabel.text = "Solar noon: \(solar_noon) UTC"
                                } else {
                                    self.solarNoonTimeLabel.text = "No data availible"
                                }
                                
                                if let day_length = currentSunPos.day_length {
                                    self.dayLengthLabel.text = "Day length: \(day_length)"
                                } else {
                                    self.dayLengthLabel.text = "No data availible"
                                }
                            }
                        }
                    })
                }
            }
        }
    }
}
