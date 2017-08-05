//
//  TodaySteps.swift
//  Step
//
//  Created by Rishi Pochiraju on 3/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import HealthKit

class TodaySteps: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todayStepsFormatted = todaySteps
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let newNum = numberFormatter.string(from: NSNumber(todayStepsFormatted))!
        
        numStepsLabel.text = "\(newNum) Steps Today"
        
        if todaySteps <= 149 {
            smallMessageLabel.text = "1% of the way to 10,000 steps"
        }else if todaySteps >= 150 && todaySteps <= 10000 {
            let percentSteps = Int(todaySteps / 100)
            smallMessageLabel.text = "\(percentSteps)% of the way to 10,000 steps"
        }else{
            smallMessageLabel.text = "Congratulations! You've reached 10,000 steps."
        }
        
    }
    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.LightContent
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeView(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var numStepsLabel: UILabel!
    @IBOutlet var smallMessageLabel: UILabel!
}
