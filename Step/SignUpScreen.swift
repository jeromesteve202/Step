//
//  SignUpScreen.swift
//  ParseStarterProject-Swift
//
//  Created by Rishi Pochiraju on 2/12/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class SignUpScreen:UIViewController, UITextFieldDelegate {
    
    @IBOutlet var signUpAction: UIButton!
  
        override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


