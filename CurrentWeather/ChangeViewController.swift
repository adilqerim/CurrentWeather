//
//  ChangeViewController.swift
//  CurrentWeather
//
//  Created by Adil on 7/31/19.
//  Copyright © 2019 Adil & Co. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
    func userEnteredANewCityName(city: String)
}

class ChangeViewController: UIViewController {
    
    var delegate : ChangeCityDelegate?
    
    @IBOutlet weak var cityTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getWeatherPressed(_ sender: Any) {
        let cityName = cityTextField.text!
        
        delegate?.userEnteredANewCityName(city: cityName)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
