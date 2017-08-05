//
//  GlobalLeadersScreen.swift
//  Step
//
//  Created by Rishi Pochiraju on 3/6/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import HealthKit

class GlobalLeadersScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UITabBar.appearance().barTintColor = tabbartint
        self.tabBarController?.tabBar.tintColor = tabbartint
        let at = [NSForegroundColorAttributeName: textColor]
        self.tabBarItem.setTitleTextAttributes(at, for: UIControlState.selected)
        
    }
    
    //    override func preferredStatusBarStyle() -> UIStatusBarStyle {
    //        return UIStatusBarStyle.LightContent
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
