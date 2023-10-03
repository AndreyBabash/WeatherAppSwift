//
//  ViewController.swift
//  weatherapp
//
//  Created by Бабаш Андрей on 01.10.2023.
//  Copyright © 2023 Бабаш Андрей. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var MyImage: UIImageView!
    @IBOutlet weak var WeatherBtn: UIButton!
    @IBOutlet weak var MyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        MyLabel.text = "Hello!!!"
        CityTextField.text="Kiev"
        WeatherBtn.addTarget(self, action: #selector(DidTapGetWeather), for: .touchUpInside)
    }
    
@objc func DidTapGetWeather()
{
    //let link="https://icons.veryicon.com/png/o/miscellaneous/tmm/a1-36-36x36.png"
    //let imageurl=URL(string:link)
    
    //let imagedata=try? Data(contentsOf: imageurl!)
    //MyImage.image=UIImage(data:imagedata!)
    
    

    var city:String
    city = CityTextField.text!
    let urlstring = "https://api.openweathermap.org/data/2.5/weather?q="+city+"&appid=ffe6d300f48841172ae985a4d1f3c576"
    let url=URL(string: urlstring)!
    let request = URLRequest(url: url)
    
    //let d = try? Data(contentsOf: url)
 
    

    let task=URLSession.shared.dataTask(with: request){ d,response,error in

        do
        {
            let json = try JSONSerialization.jsonObject(with: d!, options: .mutableContainers) as! Dictionary<String, Any>
        
            //получаем "description" и преобразуем его в массив словарей типа     <String, Array>
            let weather = json["weather"] as! Array<Dictionary<String, Any>>
    
            let description = weather[0]["description"] as! String
            
            let pic = weather[0]["icon"] as! String
            
            DispatchQueue.main.async{ self.MyImage.image = UIImage(named: pic+".png") }
            
            let main = json["main"] as! Dictionary<String, Any>
        
            let temp = main["temp"] as! Double
            
                DispatchQueue.main.async{ self.MyLabel.text="\((NSString(format: "%.2f",temp-273.15) as String)+"\t"+description)" }
    
            
        }
        catch
        {
        print("Can't parse response")
        }
    }
    task.resume()
    
}

}

