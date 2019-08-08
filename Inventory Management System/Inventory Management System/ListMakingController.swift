//
//  ListMakingController.swift
//  Inventory Management System
//
//  Created by 邱凯 on 7/8/19.
//  Copyright © 2019 MountainPeak. All rights reserved.
//

import UIKit

class ListMakingController: UIViewController {
    let userDefaults = UserDefaults.standard

    @IBOutlet weak var showText: UITextField!
    
//    var textContent: String = "11"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        showText.text = textContent
//        if(userDefaults.string(forKey: "information") != nil){
//            print(userDefaults.string(forKey: "information"))
//            showText.text = userDefaults.string(forKey: "information")
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        showText.text = textContent
        if(userDefaults.string(forKey: "information") != nil){
            print(userDefaults.string(forKey: "information"))
            showText.text = userDefaults.string(forKey: "information")
        }

    }
}
