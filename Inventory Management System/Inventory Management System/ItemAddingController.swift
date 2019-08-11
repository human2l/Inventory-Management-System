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
    
    @IBOutlet weak var barcodeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountSlider: UISlider!
    @IBOutlet weak var selectProductBtn: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popoverView.layer.cornerRadius = 10

    }
    
    override func viewWillAppear(_ animated: Bool) {
        rowsArray = []
        selectProductBtn.isEnabled = false
        if(userDefaults.string(forKey: "newBarcode") != nil && userDefaults.string(forKey: "newBarcode") != ""){
            barcodeLabel.text = userDefaults.string(forKey: "newBarcode")
        }
        
        rowsArray = checkExist()
        if(rowsArray.count == 0 || rowsArray[0] == [""]){
            nameLabel.text = "None"
            priceLabel.text = String(price)
        }else if(rowsArray.count == 1){
            nameLabel.text = rowsArray[0][1]
            price = Float(rowsArray[0][2]) as! Float
            priceLabel.text = String(price)
            refreshAmountAndTotalPrice()
        }else{
            selectProductBtn.isEnabled = true
            nameLabel.text = "Multiple product found! please select product!"
        }
    }
    
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
        if(barcodeLabel.text == "None" || nameLabel.text == "None" || nameLabel.text == "Multiple product found! please select product!" || amountLabel.text == "0"){
            let alert = UIAlertController(title: "Form is incomplete!", message: "Please check if: 1.You are saving an empty product. 2.Item with current barcode does not exist. 3.You have not select the number of amount", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{ Utils.tempPurchaseList.append([barcodeLabel.text!,nameLabel.text!,String(price),String(amount)])
        }
    }
}
