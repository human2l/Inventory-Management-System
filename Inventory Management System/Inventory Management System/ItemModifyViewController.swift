//
//  ItemModifyViewController.swift
//  Inventory Management System
//
//  Created by 邱凯 on 11/8/19.
//  Copyright © 2019 MountainPeak. All rights reserved.
//

import Foundation
import UIKit

class ItemModifyViewController: UIViewController {
    var amount = -1
    var itemIndex:Int = -1
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        amount = Utils.tempPurchaseList[itemIndex][3]
        amountLabel.text = Utils.tempPurchaseList[itemIndex][3]
        slider.value = Float(Utils.tempPurchaseList[itemIndex][3]) as! Float
    }
    
    @IBAction func onSlide(_ sender: Any) {
        amountLabel.text = String(Int(slider.value))
    }
    @IBAction func onTapSaveBtn(_ sender: Any) {
        Utils.tempPurchaseList[itemIndex][3] = amountLabel.text!
    }
    
    @IBAction func onTapDeleteBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Item", message: "Are you sure to delete this item?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            Utils.tempPurchaseList.remove(at: self.itemIndex)
            self.performSegue(withIdentifier: "BackToListMakingView", sender: sender)
        }))
        self.present(alert, animated: true)
    }
    
}
