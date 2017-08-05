//
//  HealthKitManager.swift
//  Step
//
//  Created by Rishi Pochiraju on 3/3/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation
import HealthKit
import UIKit
import HealthKitUI
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class HealthKitManager {
    
    init(){
        authorizeHealthKit()
    }
    
    let healthStore = HKHealthStore()
    
    func authorizeHealthKit() -> Bool {
        var isEnabled = true
        
        if HKHealthStore.isHealthDataAvailable() {
            let stepsCount = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!)
            
            let dataTypesToRead = NSSet(object: stepsCount)
            let dataTypesToWrite = NSSet(object: stepsCount)
            
            healthStore.requestAuthorization(toShare: nil, read: stepsCount as? Set<HKObjectType>, completion: { (success, error) in
                isEnabled = success
            })
            
            
        }else{
            isEnabled = false
        }
        
        return isEnabled
    }
    
    func recentSteps() {
        
        if HKHealthStore.isHealthDataAvailable() {
            let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) // The type of data we are requesting
        
            let date = Date()
            let cal = Calendar(identifier: Calendar.Identifier.gregorian)
            let newDate = cal.startOfDay(for: date)
            let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: HKQueryOptions()) // Our search predicate which will fetch all steps taken today
        
            // The actual HealthKit Query which will fetch all of the steps and add them up for us.
            let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) { query, results, error in
                var steps: Double = 0
            
                if results?.count > 0 {
                    for result in results as! [HKQuantitySample] {
                        steps += result.quantity.doubleValue(for: HKUnit.count())
                    }
                
                    todaySteps = Int(steps)
                }
            }
        
            healthStore.execute(query)
            
        }
    }
    
 
}
