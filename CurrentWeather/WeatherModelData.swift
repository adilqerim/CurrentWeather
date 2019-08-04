//
//  WeatherModelData.swift
//  CurrentWeather
//
//  Created by Adil on 7/31/19.
//  Copyright © 2019 Adil & Co. All rights reserved.
//

import Foundation
import UIKit
class WeatherModelData {
    var cityName = ""
    var temp = 0
    var imageId = 0

    
    
    func iconIdentifier(_ iconNumber: Int ) -> String {
        var imageName = ""
        switch iconNumber {
        case 800...850:
           imageName = "cloud"
        default: break
        }
        return imageName
    }
}
