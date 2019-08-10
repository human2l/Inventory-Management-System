//
//  Utils.swift
//  Inventory Management System
//
//  Created by 邱凯 on 10/8/19.
//  Copyright © 2019 MountainPeak. All rights reserved.
//

import Foundation

class Utils{
    static let userDefaults = UserDefaults.standard
    static var tempPurchaseList: [[String]] = []
    
    static func getStorageArray() ->[[String]]{
        return userDefaults.value(forKey: "storageData") as! [[String]]
    }
    
    
}
