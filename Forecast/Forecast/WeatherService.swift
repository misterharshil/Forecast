//
//  WeatherService.swift
//  Forecast
//
//  Created by Harshil on 06/03/16.
//  Copyright © 2016 Harshil Parikh. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate {

    func setWeather(weather: Weather)
}

class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    // Creating Weather Service for the Forecast Application
    
    func getWeather(city: String) {
        
        // Escape Sequence
        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
    
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=44db6a862fba0b067b1930da0d769e98"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            //print(">>>>>\(data)")
            let json = JSON(data: data!)
            
            // getting weather
            let temp = json["main"]["temp"].double
            let name = json["name"].string
            let desc = json["weather"][0]["description"].string
            let wind = json["wind"]["speed"].double
           // let icon = json["weather"]["0"]["icon"].string
            let hum = json["main"]["humidity"].double
            //let min = json["main"]["temp_min"].double
            
            
            let weather = Weather(cityName: name!,temp: temp!, description: desc!,wind: wind!,hum: hum!)
           
            if self.delegate != nil {
                
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                      self.delegate?.setWeather(weather)
                })
                
                
            }
            
        }
        task.resume()
  
        
    }
}