//
//  ViewController.swift
//  Forecast
//
//  Created by Harshil on 06/03/16.
//  Copyright © 2016 Harshil Parikh. All rights reserved.
//

import UIKit

extension String {
    func firstchar() -> String {
        let lowercaseString = self.lowercaseString
        
        return lowercaseString.stringByReplacingCharactersInRange(lowercaseString.startIndex...lowercaseString.startIndex, withString: String(lowercaseString[lowercaseString.startIndex]).uppercaseString)
    }
}



class ViewController: UIViewController, WeatherServiceDelegate {
    
    // Creating Instance of WeatherService Class
    let weatherService = WeatherService()
    
    
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var wind: UILabel!
   
    @IBOutlet weak var hums: UILabel!
    
    
    @IBAction func setCityTapped(sender: UIButton) {
        // Calling City name alert
        openCityAlert()
        
    }
    
    
   
    
    func openCityAlert() {
        
        
        //create Alert
        let alert = UIAlertController(title: "City", message: "Enter city name", preferredStyle: UIAlertControllerStyle.Alert)
        
        //create cancel
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        //create ok
        let ok = UIAlertAction(title: "Confirm", style: .Default) { (action: UIAlertAction) -> Void in
            let textField = alert.textFields?[0]
            //print(textField?.text!)
           // self.cityLabel.text = textField?.text!
            // Passing the CIty name
            let cityName = textField?.text
            self.weatherService.getWeather(cityName!)
            self.tempLabel.hidden = false
            self.descriptionLabel.hidden = false
            self.hums.hidden = false
            self.wind.hidden = false
            
        }
        
        //Add text field
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
           
            
        }
        
        // adding actions to alert box
        alert.addAction(cancel)
        alert.addAction(ok)
        
        
        // show dialog
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    //Mark: - Weather Service Delegate 
    
    func setWeather(weather: Weather) {
        
      //NSNumberFormatting
        
        let formatter = NSNumberFormatter()
        let c = formatter.stringFromNumber(weather.temp - 273.15)!
        let h = formatter.stringFromNumber(weather.hum)!
        
    
        print(weather.temp)
       // cityLabel.text = weather.cityName.uppercaseString
        tempLabel.text = "\(c)°C"
        wind.text = " Wind speed : " + "\(weather.wind) MPH".firstchar()
        descriptionLabel.text = weather.description.firstchar()
        cityButton.setTitle(weather.cityName, forState: .Normal)
        hums.text = "Humidity level : " + "\(h) %".firstchar()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.weatherService.delegate = self
        tempLabel.hidden = true
        descriptionLabel.hidden = true
        hums.hidden = true
        self.wind.hidden = true
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

