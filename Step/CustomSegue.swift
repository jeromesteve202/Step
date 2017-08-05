//
//  CustomSegue.swift
//  ParseStarterProject-Swift
//
//  Created by Rishi Pochiraju on 2/12/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    override func perform(){
        
        let sourceVC = self.source
        let destinationVC = self.destination
        
        let window = UIApplication.shared.keyWindow!
        destinationVC.view.alpha = 0.0
        window.insertSubview(destinationVC.view, belowSubview: sourceVC.view)
        
        UIView.animate(withDuration: 0.5, animations: {() ->
            Void in
            sourceVC.view.alpha = 0.0
            destinationVC.view.alpha = 1.0
        }, completion: {
            (finished) -> Void in
            sourceVC.view.alpha = 0.0
            sourceVC.present(destinationVC, animated: false, completion: nil)
        })
    }
}
