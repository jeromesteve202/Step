/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import HealthKit
import Firebase
import GoogleSignIn


var isSignedIn = false
let tabbartint = UIColor(red:0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.65)
let textColor = UIColor(red:255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
var todayDate = -2

var finalUsername = ""
var finalScreenName = ""


//declare global variables for steps and rank

//these need to be pulled locally then committed to the cloud
var todaySteps = 0
var weekSteps = 0

//these need to be calculated by a sorting algorithm based on cloud data for other users' steps
//then they need to be recommitted to the cloud in order
var rankAmongFriends = 0
var globalRank = 0

class ViewController: UIViewController{
    
    var timer = Timer()
    var counter = 0
    
    let customColor = UIColor(red: 254/255.0, green: 212/255.0, blue: 52/255.0, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        HealthKitManager().recentSteps()
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)

    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func updateTimer(){
        if counter == 0{
            createFirstRect()
        }else if counter == 1 {
            createSecondRect()
        }else if counter == 2 {
            createThirdRect()
        }else if counter == 4 {
//            if (PFUser.currentUser() == nil) {
//                timer.invalidate()
//                print("no user signed in")
//                performSegueWithIdentifier("goToLogin", sender: nil)
//            }else{
                print("user is signed in")
            
            
            // USER IS SIGNED IN BY DEFAULT - CHANGE WHEN SWITCHING TO GOOGLE
            
            
                timer.invalidate()
                performSegue(withIdentifier: "goToMain", sender: nil)
            //}
        }
        
        
        counter += 1
    }
    
    func createFirstRect(){
        let bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        // Create CAShapeLayerS
        let rectShape = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position.x = 100
        rectShape.position.y = self.view.frame.size.height / 2
        rectShape.cornerRadius = bounds.width / 2
        view.layer.addSublayer(rectShape)
        
        // Apply effects here
        
        // setup
        let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
        rectShape.bounds = rect
        rectShape.position.x = 100
        rectShape.position.y = self.view.frame.size.height / 2 - 40
        rectShape.path = UIBezierPath(rect:rect).cgPath
        
        // 1
        rectShape.lineWidth = 0.5
        rectShape.strokeColor = customColor.cgColor
        rectShape.opacity = 1.0
        
        // animate
        let animation = CABasicAnimation(keyPath: "lineWidth")
        // 2
        animation.toValue = 40
        animation.duration = 0.33 // duration is 1 sec
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut) // animation curve is Ease Out
        animation.fillMode = kCAFillModeBoth // keep to value after finishing
        animation.isRemovedOnCompletion = false // don't remove after finishing
        rectShape.add(animation, forKey: animation.keyPath)
    }
    
    func createSecondRect(){
        let bounds = CGRect(x: 0, y: 0, width: 40, height: 80)
        
        // Create CAShapeLayerS
        let rectShape = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position.x = 100
        rectShape.position.y = self.view.frame.size.height / 2
        rectShape.cornerRadius = bounds.width / 2
        view.layer.addSublayer(rectShape)
        
        // Apply effects here
        
        // setup
        let rect = CGRect(x: 0, y: 0, width: 40, height: 80)
        rectShape.bounds = rect
        rectShape.position.x = 185
        rectShape.position.y = self.view.frame.size.height / 2 - 60
        rectShape.path = UIBezierPath(rect:rect).cgPath
        
        // 1
        rectShape.lineWidth = 0.5
        rectShape.strokeColor = customColor.cgColor
        rectShape.opacity = 1.0
        
        // animate
        let animation = CABasicAnimation(keyPath: "lineWidth")
        // 2
        animation.toValue = 40
        animation.duration = 0.33 // duration is 1 sec
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut) // animation curve is Ease Out
        animation.fillMode = kCAFillModeBoth // keep to value after finishing
        animation.isRemovedOnCompletion = false // don't remove after finishing
        rectShape.add(animation, forKey: animation.keyPath)

    }
    
    func createThirdRect(){
        let bounds = CGRect(x: 0, y: 0, width: 40, height: 120)
        
        // Create CAShapeLayerS
        let rectShape = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position.x = 100
        rectShape.position.y = self.view.frame.size.height / 2
        rectShape.cornerRadius = bounds.width / 2
        view.layer.addSublayer(rectShape)
        
        // Apply effects here
        
        // setup
        let rect = CGRect(x: 0, y: 0, width: 40, height: 120)
        rectShape.bounds = rect
        rectShape.position.x = 270
        rectShape.position.y = self.view.frame.size.height / 2 - 80
        rectShape.path = UIBezierPath(rect:rect).cgPath
        
        // 1
        rectShape.lineWidth = 0.5
        rectShape.strokeColor = customColor.cgColor
        rectShape.opacity = 1.0
        
        // animate
        let animation = CABasicAnimation(keyPath: "lineWidth")
        // 2
        animation.toValue = 40
        animation.duration = 0.33 // duration is 1 sec
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut) // animation curve is Ease Out
        animation.fillMode = kCAFillModeBoth // keep to value after finishing
        animation.isRemovedOnCompletion = false // don't remove after finishing
        rectShape.add(animation, forKey: animation.keyPath)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
