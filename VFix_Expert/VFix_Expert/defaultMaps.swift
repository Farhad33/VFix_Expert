//
//  defaultMaps.swift
//  VFix_Expert
//
//  Created by Noureddine Youssfi on 4/7/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit
import TPDMapsApp

var defaultMapApp: TPDMapsApp?
let userDefaults = NSUserDefaults.standardUserDefaults()
class defaultMaps: TPDMapsApp {
    func setDefault(map: TPDMapsApp){
        defaultMapApp = map
//        let setDefaultMapData = NSKeyedArchiver.archivedDataWithRootObject(defaultMapApp!)
        switch defaultMapApp!.name {
            
        case "Apple":
            print("its apple")
            
            userDefaults.setObject(0, forKey: "default_map")
            userDefaults.synchronize()
            break
        case "Google":
            print("its google")
            
            userDefaults.setObject(1, forKey: "default_map")
            userDefaults.synchronize()
            break
        case "Waze":
            print("its waze")
            
            userDefaults.setObject(2, forKey: "default_map")
            userDefaults.synchronize()
            break
        default:
            print("its weird")
        }
//        print(defaultMapApp!.name)
        
        
    }
    
    
}
