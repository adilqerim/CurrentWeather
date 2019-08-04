//
//  ViewController.swift
//  CurrentWeather
//
//  Created by Adil on 7/24/19.
//  Copyright © 2019 Adil & Co. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
  
    
    
    let WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"
    
    let locationManager = CLLocationManager()
    let weatherModelData = WeatherModelData()
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIconView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    func getWeatherData(url: String, parameters: [String : String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherJSON = JSON(response.result.value!)
                
                self.updateWeatherData(json : weatherJSON)
            }
        }
    }
    
    func updateWeatherData(json : JSON){
        if let temp = json["main"]["temp"].double {
            weatherModelData.temp = Int(temp - 273.15)
            
            weatherModelData.cityName = json["name"].stringValue
            
            weatherModelData.imageId = json["weather"][0]["id"].int!
            
            updateUIWeatherScreen()
        }
    }
    
    func updateUIWeatherScreen() {
        cityLabel.text = weatherModelData.cityName
        tempLabel.text = String(weatherModelData.temp)
        
        weatherIconView.image = UIImage(named: weatherModelData.iconIdentifier(weatherModelData.imageId))
        
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let parameters = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: parameters)
            
        } else {
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        cityLabel.text = "Unavalable"
    }
    
    @IBAction func changeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToChangeScreen", sender: self)
    }
    
    func userEnteredANewCityName(city: String) {
        let newParams = ["q" : city, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: newParams)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToChangeScreen" {
            
            let destinationVC = segue.destination as! ChangeViewController
            
            destinationVC.delegate = self
        }
    }
}

