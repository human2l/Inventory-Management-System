//
//  ListMakingController.swift
//  Inventory Management System
//
//  Created by 邱凯 on 7/8/19.
//  Copyright © 2019 MountainPeak. All rights reserved.
//

import UIKit

class ItemAddingController: UIViewController {
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var barcodeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountSlider: UISlider!
    
    
//    var textContent: String = "11"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        showText.text = textContent
//        if(userDefaults.string(forKey: "information") != nil){
//            print(userDefaults.string(forKey: "information"))
//            showText.text = userDefaults.string(forKey: "information")
//        }
        
        
//        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
//        button.backgroundColor = .green
//        button.setTitle("Test Button", for: .normal)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//
//        self.view.addSubview(button)
    }
//    @objc func buttonAction(sender: UIButton!) {
//        print("Button tapped")
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(userDefaults.string(forKey: "newBarcode") != nil && userDefaults.string(forKey: "newBarcode") != ""){
//            print(userDefaults.string(forKey: "newBarcode"))
            barcodeLabel.text = userDefaults.string(forKey: "newBarcode")
        }

    }
    
    @IBAction func onSlide(_ sender: UISlider) {
        amountLabel.text = String(Int(sender.value))
    }
    
}
