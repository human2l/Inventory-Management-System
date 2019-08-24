//
//  ItemCreatingController.swift
//  Inventory Management System
//
//  Created by 邱凯 on 24/8/19.
//  Copyright © 2019 MountainPeak. All rights reserved.
//

import Foundation
import UIKit

class ItemCreatingController: UIViewController{
    let userDefaults = UserDefaults.standard
    var name:String = ""
    var price:Float = 0.0
    var amount:Int = 0
    
    @IBOutlet weak var barcodeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.layer.cornerRadius = 4
        saveBtn.layer.cornerRadius = 4
        
        setupTextFields_Barcode()
        setupTextFields_Name()
        setupTextFields_Price()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        userDefaults.setValue("", forKey: "newBarcode")
    }
    
    //This would show a Done button when user click the BarcodeTextField
    func setupTextFields_Barcode() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction_Barcode))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        barcodeTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction_Barcode(){
        self.view.endEditing(true)
    }
    
    //This would show a Done button when user click the BarcodeTextField
    func setupTextFields_Name() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction_Name))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        nameTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction_Name(){
        self.view.endEditing(true)
    }
    
    //This would show a Done button when user click the BarcodeTextField
    func setupTextFields_Price() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction_Price))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        priceTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction_Price(){
        let periodAppearanceTimes = priceTextField.text!.filter { $0 == "." }.count
        if(periodAppearanceTimes > 1){
            let alert = UIAlertController(title: "Invalid Input!", message: "You have input more than one period, please retry.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        if(priceTextField.text == ""){
            priceTextField.text = "0.0"
        }
        refreshAmountAndTotalPrice()
        self.view.endEditing(true)
    }
    
    
    @IBAction func onSlide(_ sender: Any) {
        refreshAmountAndTotalPrice()
    }
    
    
    
    private func refreshAmountAndTotalPrice(){
        amount = Int(slider.value)
        price = Float(priceTextField.text!) as! Float
        amountLabel.text = String(amount)
        totalPriceLabel.text = String(format: "%.2f", Float(amount) * price)
    }
    
    @IBAction func onTapSaveBtn(_ sender: Any) {
        var incomplete:Bool = false
        var incompleteString:String = ""
        if(barcodeTextField.text == ""){
            incompleteString.append("Barcode, ")
            incomplete = true
        }
        if(nameTextField.text == ""){
            incompleteString.append("Name, ")
            incomplete = true
        }
        if(priceTextField.text == "0.0"){
            incompleteString.append("Price, ")
            incomplete = true
        }
        if(amountLabel.text == "0"){
            incompleteString.append("Amount, ")
            incomplete = true
        }
        if(incomplete){
            incompleteString.remove(at: incompleteString.index(before: incompleteString.endIndex))
            incompleteString.remove(at: incompleteString.index(before: incompleteString.endIndex))
            let alert = UIAlertController(title: "Form is incomplete!", message: "Please check: "+incompleteString, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            Utils.tempPurchaseList.append([barcodeTextField.text!,nameTextField.text!,String(price),String(amount)])
        }
    }
    
}
