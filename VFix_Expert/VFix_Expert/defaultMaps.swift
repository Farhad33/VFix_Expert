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
var defaultMap: TPDMapsApp?
let userDefaults = NSUserDefaults.standardUserDefaults()
class defaultMaps: TPDMapsApp {
    func setDefault(map: TPDMapsApp){
        defaultMapApp = map
//        let setDefaultMapData = NSKeyedArchiver.archivedDataWithRootObject(defaultMapApp!)
//        userDefaults.setObject(setDefaultMapData, forKey: "default_map")
        print(defaultMapApp!.name)
        
    }
//    func getDefaultMap() {
//        if let getDefaultMapData = userDefaults.objectForKey("default_map") as? NSData{
//            if let getDefaultMapApp = NSKeyedUnarchiver.unarchiveObjectWithData(getDefaultMapData) as? TPDMapsApp{
//                defaultMap = getDefaultMapApp
//            }
//        }
//        
//    }
    
}
