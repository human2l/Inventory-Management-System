//
//  ListMakingController.swift
//  Inventory Management System
//
//  Created by 邱凯 on 7/8/19.
//  Copyright © 2019 MountainPeak. All rights reserved.
//

import UIKit

class ListMakingController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var addItemBtn: UIButton!
    @IBOutlet weak var exportBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        
//        cell.textLabel?.text = String(indexPath.row+1)+": \(sortedScores![indexPath.row].key) \(sortedScores![indexPath.row].value)"
        cell.textLabel?.text = String(indexPath.row+1)+": \(111) \(222)"
        return cell
    }
    
    @IBAction func onTapAddItemBtn(_ sender: Any) {
        userDefaults.setValue("", forKey: "newBarcode")
    }
    
    @IBAction func export(_ sender: Any) {
        let fileName = "Tasks.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = "Date,Task,Time Started,Time Ended\n"
        
        var newLine = "9/12,Designing,09:35,11:02"
        csvText += newLine
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
    
    
//    func export() {
//        let fileName = "Tasks.csv"
//        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
//        var csvText = "Date,Task,Time Started,Time Ended\n"
//
//        var newLine = "9/12,Designing,09:35,11:02"
//        csvText += newLine
//        do {
//            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
//        } catch {
//            print("Failed to create file")
//            print("\(error)")
//        }
//
//        let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
//        present(vc, animated: true, completion: nil)
//
//        vc.excludedActivityTypes = [
//            UIActivity.ActivityType.assignToContact,
//            UIActivity.ActivityType.saveToCameraRoll,
//            UIActivity.ActivityType.postToFlickr,
//            UIActivity.ActivityType.postToVimeo,
//            UIActivity.ActivityType.postToTencentWeibo,
//            UIActivity.ActivityType.postToTwitter,
//            UIActivity.ActivityType.postToFacebook,
//            UIActivity.ActivityType.openInIBooks
//        ]
//    }
    
}
