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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var addItemBtn: UIButton!
    @IBOutlet weak var exportBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.layer.cornerRadius = 4
        addItemBtn.layer.cornerRadius = 4
        exportBtn.layer.cornerRadius = 4
        resetBtn.layer.cornerRadius = 4
        
        let contentWidth = scrollView.bounds.width
        let contentHeight = scrollView.bounds.height * 16
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        var tempPurchaseList = Utils.tempPurchaseList
        var totalPrice:Float = 0.0
        if(tempPurchaseList.count != 0){
            for index in 0...tempPurchaseList.count-1{
                let button = UIButton(frame: CGRect(x: 0, y: 75*index, width: 350, height: 50))
                if(index%2 == 0){
                    button.backgroundColor = .purple
                }else{
                    button.backgroundColor = .orange
                }
                
                button.setTitle(tempPurchaseList[index][1], for: .normal)
                button.titleLabel?.font = UIFont(name: "System", size: 10)
                button.titleLabel?.numberOfLines = 2
                button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                //use index as button tag
                button.tag = index
                
                var label = UILabel(frame: CGRect(x: 0, y: 75*index+50, width: 350, height: 20))
                if(index%2 == 0){
                    label.backgroundColor = .purple
                }else{
                    label.backgroundColor = .orange
                }
                label.textColor = .white
                label.textAlignment = NSTextAlignment.center
                let totalPricePerProduct = (tempPurchaseList[index][2] as NSString).floatValue * (tempPurchaseList[index][3] as NSString).floatValue
                label.text = "Price: " + tempPurchaseList[index][2] + " Amount: " + tempPurchaseList[index][3] + " Total Price: " + String(totalPricePerProduct)
                totalPrice += totalPricePerProduct
                scrollView.addSubview(button)
                scrollView.addSubview(label)
            }
            totalPriceLabel.text = String(totalPrice)
        }
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.performSegue(withIdentifier: "ModifyItem", sender: sender)
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "ModifyItem" && sender is UIButton) {
            let imvc = segue.destination as! ItemModifyViewController
            imvc.itemIndex =  (sender as! UIButton).tag
        }
    }
    
    
    @IBAction func onTapAddItemBtn(_ sender: Any) {
        userDefaults.setValue("", forKey: "newBarcode")
    }
    
    @IBAction func export(_ sender: Any) {
        let tempPurchaseList = Utils.tempPurchaseList
        if(tempPurchaseList.count == 0){
            let alert = UIAlertController(title: "Warning", message: "You have no items in list, export failed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            let fileName = "Purchase List.csv"
            let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
            var csvText = "Barcode,Description,Price,Amount,Total Price\n"
            
            for index in 0...tempPurchaseList.count-1{
                let totalPricePerProduct = (tempPurchaseList[index][2] as NSString).floatValue * (tempPurchaseList[index][3] as NSString).floatValue
                var rowString = ""
                for index2 in 0...tempPurchaseList[index].count-1{
                    rowString += (tempPurchaseList[index][index2] + ",")
                }
                rowString.append(String(totalPricePerProduct)+"\n")
                csvText += rowString
            }
            csvText += totalPriceLabel.text!
            do {
                try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("Failed to create file")
                print("\(error)")
            }
            
            let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
            present(vc, animated: true, completion: nil)
            
            vc.excludedActivityTypes = [
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToTwitter,
                UIActivity.ActivityType.postToFacebook,
                UIActivity.ActivityType.openInIBooks
            ]
        }
        
    }
    
    @IBAction func onTapResetBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Reset List", message: "This will clear all items in the list, continue?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { action in
            Utils.tempPurchaseList.removeAll()
            self.performSegue(withIdentifier: "BackToHomeView", sender: sender)
        }))
        self.present(alert, animated: true)
    }
    
    
}
