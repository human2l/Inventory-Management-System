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
    var rowsArray: [[String]] = []
    var price:Float = 0.0
    var amount:Int = 0
    var totalPrice:Float = 0.0
    
    
    @IBOutlet var popoverView: UIScrollView!
    
    @IBOutlet weak var barcodeTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountSlider: UISlider!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var selectProductBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.layer.cornerRadius = 4
        scanBtn.layer.cornerRadius = 4
        selectProductBtn.layer.cornerRadius = 4
        saveBtn.layer.cornerRadius = 4
        
        setupTextFields()
        self.popoverView.layer.cornerRadius = 10

    }
    
    //This would show a Done button when user click the BarcodeTextField
    func setupTextFields() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        barcodeTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction(){
        if(barcodeTextField.text != ""){
            userDefaults.setValue(barcodeTextField.text, forKey: "newBarcode")
            checkHasItem()
        }
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rowsArray = []
        selectProductBtn.isEnabled = false
        selectProductBtn.backgroundColor = .gray
        if(userDefaults.string(forKey: "newBarcode") != nil && userDefaults.string(forKey: "newBarcode") != ""){
            barcodeTextField.text = userDefaults.string(forKey: "newBarcode")
        }
        checkHasItem()
    }
    
    //Do "checkExist()" then update the data to the field
    private func checkHasItem(){
        rowsArray = checkExist()
        if(rowsArray.count == 0 || rowsArray[0] == [""]){
            nameLabel.text = "None"
            priceLabel.text = "0.0"
        }else if(rowsArray.count == 1){
            nameLabel.text = rowsArray[0][1]
            price = Float(rowsArray[0][2]) as! Float
            priceLabel.text = String(price)
            refreshAmountAndTotalPrice()
        }else{
            selectProductBtn.isEnabled = true
            selectProductBtn.backgroundColor = .orange
            priceLabel.text = "0.0"
            nameLabel.text = "Multiple product found! please select product!"
        }
    }
    
    //Check "newBarcode" exist or not in the csv list
    private func checkExist() -> [[String]]{
        let storatgeArray = Utils.getStorageArray()
        var rowsArray: [[String]] = []
        for row in storatgeArray {
            let rowArray = row as [String]
            if (row[0] == userDefaults.string(forKey: "newBarcode")){
                rowsArray.append(rowArray)
            }
        }
        return rowsArray
    }
    
    @IBAction func onSlide(_ sender: UISlider) {
        refreshAmountAndTotalPrice()
    }
    
    @IBAction func onSelectProduct(_ sender: Any) {
        popoverView.center = self.view.center
        for index in 0...rowsArray.count-1{
            let button = UIButton(frame: CGRect(x: 0, y: 50*index, width: 350, height: 45))
            button.backgroundColor = .black
            button.setTitle(rowsArray[index][1], for: .normal)
            button.titleLabel?.font = UIFont(name: "System", size: 10)
            button.titleLabel?.numberOfLines = 2
            button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            button.tag = index
            popoverView.addSubview(button)
        }
        self.view.addSubview(popoverView)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        nameLabel.text = sender.titleLabel!.text
        priceLabel.text = rowsArray[sender.tag][2]
        refreshAmountAndTotalPrice()
        self.popoverView.removeFromSuperview()
    }
    
    @IBAction func onTapPopoverBackBtn(_ sender: Any) {
        self.popoverView.removeFromSuperview()
    }
    
    private func refreshAmountAndTotalPrice(){
        amount = Int(amountSlider.value)
        price = Float(priceLabel.text!) as! Float
        amountLabel.text = String(amount)
        totalPriceLabel.text = String(Float(amount) * price)
    }
    
    @IBAction func onTapScan(_ sender: Any) {
        priceLabel.text = "0.0"
        refreshAmountAndTotalPrice()
    }
    
    @IBAction func onTapSaveBtn(_ sender: Any) {
        if(barcodeTextField.text == "" || nameLabel.text == "None" || nameLabel.text == "Multiple product found! please select product!" || amountLabel.text == "0"){
            let alert = UIAlertController(title: "Form is incomplete!", message: "Please check if: 1.You are saving an empty product. 2.Item with current barcode does not exist. 3.You have not select the number of amount", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{ Utils.tempPurchaseList.append([barcodeTextField.text!,nameLabel.text!,String(price),String(amount)])
        }
    }
}
