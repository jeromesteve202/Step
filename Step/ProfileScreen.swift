//
//  LogInScreen.swift
//  ParseStarterProject-Swift
//
//  Created by Rishi Pochiraju on 2/12/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import HealthKit
import Firebase

var profileImageGlobal :UIImageView = UIImageView()
var oldProfileImageGlobal:UIImageView = UIImageView()

class ProfileScreen:UIViewController {
    
    @IBOutlet var profilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProfile()
        initializeHKStats()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeHKStats()
        setNames()
        UITabBar.appearance().barTintColor = tabbartint
        self.tabBarController?.tabBar.tintColor = tabbartint
        let at = [NSForegroundColorAttributeName: textColor]
        self.tabBarItem.setTitleTextAttributes(at, for: UIControlState.selected)
        
        if profilePicDidChangeGlobal == true {
            profilePic.image = profileImageGlobal.image
            profilePic.contentMode = .scaleAspectFill
        }else{
            profileImageGlobal.image = profilePic.image
        }
        
        profilePicDidChangeGlobal = false
        
    }
    
    func setNames() {
    
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logOutAction(_ sender: AnyObject) {
        
//        let alertController = UIAlertController(title: "Log Out", message: "Are you sure?", preferredStyle: .Alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
//        let DestructiveAction = UIAlertAction(title: "No", style: .Default) {
//            (result : UIAlertAction) -> Void in
//        }
//        
//        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
//        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) {
//            (result : UIAlertAction) -> Void in
//            
//            self.performSegueWithIdentifier("goBack", sender: nil)
//        }
//        
//        alertController.addAction(DestructiveAction)
//        alertController.addAction(okAction)
//        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var screenName: UILabel!
    
    func setUpProfile() {
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 1.8 * self.view.frame.size.width / 414
        profilePic.clipsToBounds = true
        profilePic.layer.masksToBounds = true
        profilePic.layer.borderWidth = 5.0
        profilePic.layer.borderColor = UIColor.gray.cgColor
       //profilePic.layer.borderColor = UIColor(red: 46/255.0, green: 108/255.0, blue: 164/255.0, alpha: 0.9).CGColor
        
        if profilePicDidChangeGlobal == true {
            profilePic.image = profileImageGlobal.image
        }else{
            profileImageGlobal.image = profilePic.image
        }
        
        profilePicDidChangeGlobal = false
        
    }

    @IBOutlet var todayLabel: UIButton!
    @IBOutlet var thisWeekLabel: UIButton!
    @IBOutlet var friendsLabel: UIButton!
    @IBOutlet var friendsRankLabel: UIButton!
    @IBOutlet var globalRankLabel: UIButton!
    
    func initializeHKStats() {
        if HKHealthStore.isHealthDataAvailable() {
            HealthKitManager().recentSteps()
            SecondHKitManager().recentSteps()
            let todayStepsFormatted = todaySteps
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            let newNum = numberFormatter.string(from: NSNumber(todayStepsFormatted))!
            todayLabel.setTitle("       Today's Steps: \(newNum)", for: UIControlState())
            
            while weekSteps == 0 {
                thisWeekLabel.setTitle("       This Week's Steps: Loading...", for: UIControlState())
            }
        
            let weekStepsFormaated = weekSteps
            let numberFormatter2 = NumberFormatter()
            numberFormatter2.numberStyle = NumberFormatter.Style.decimal
            let newNum2 = numberFormatter2.string(from: NSNumber(weekStepsFormaated))!
            thisWeekLabel.setTitle("       This Week's Steps: \(newNum2)", for: UIControlState())
        }else{
            thisWeekLabel.setTitle("       This Week's Steps: No Data", for: UIControlState())
            todayLabel.setTitle("       Today's Steps: No Data", for: UIControlState())
        }
    }
    
}
