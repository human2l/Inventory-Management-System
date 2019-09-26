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
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var noteTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.layer.cornerRadius = 4
        deleteBtn.layer.cornerRadius = 4
        saveBtn.layer.cornerRadius = 4
        
        setupTextFields_Note()
        
//        amount = Utils.tempPurchaseList[itemIndex][3]
        amountLabel.text = Utils.tempPurchaseList[itemIndex][3]
        noteTextField.text = Utils.tempPurchaseList[itemIndex][4]
        slider.value = Float(Utils.tempPurchaseList[itemIndex][3]) as! Float
    }
    
    @IBAction func onSlide(_ sender: Any) {
        amountLabel.text = String(Int(slider.value))
    }
    @IBAction func onTapSaveBtn(_ sender: Any) {
        Utils.tempPurchaseList[itemIndex][3] = amountLabel.text!
        Utils.tempPurchaseList[itemIndex][4] = noteTextField.text!
    }
    
    //This would show a Done button when user click the BarcodeTextField
    func setupTextFields_Note() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction_Note))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        noteTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction_Note(){
        self.view.endEditing(true)
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
