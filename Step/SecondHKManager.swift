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


class SecondHKitManager {
    
    init(){
        authorizeHealthKit()
    }
    
    let healthStore = HKHealthStore()
    
    func authorizeHealthKit() -> Bool {
        var isEnabled = true
        
        if HKHealthStore.isHealthDataAvailable() {
            let stepsCount = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!)
            
            healthStore.requestAuthorization(toShare: nil, read: stepsCount as? Set<HKObjectType>, completion: { (success, error) in
                isEnabled = success
            })
            
            
        }else{
            isEnabled = false
        }
        
        return isEnabled
    }
    
    //start at Sunday morning and get the steps since then...if the day is sunday, then today's steps are the same steps for the week
    //otherwise need to find Sunday and assign that value
    func recentSteps() {
        if HKHealthStore.isHealthDataAvailable() {
            let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) // The type of data we are requesting
            
            var ndate = Date()
            var days : [String] = []
            
            let today = Date()
            let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
            let myComponents = (myCalendar as NSCalendar).components(.weekday, from: today)
            let weekDay = myComponents.weekday
            todayDate = weekDay!
            let stopDate = weekDay! - 1

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
            
            let cal = Calendar(identifier: Calendar.Identifier.gregorian)
                        
            if stopDate != 0 {
            
                for _ in 0...stopDate {
                    days.append(dateFormatter.string(from: ndate))
                
                    // move on to the next day
                    ndate = (Calendar.current as NSCalendar).date(
                        byAdding: .day,
                        value: -1,
                        to: ndate,
                        options: NSCalendar.Options(rawValue: 0))!
                }
            }
            
            let newDate = cal.startOfDay(for: ndate)
            let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: HKQueryOptions()) // Our search predicate which will fetch all steps taken today
            
            // The actual HealthKit Query which will fetch all of the steps and add them up for us.
            let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) { query2, results, error in
                var steps: Double = 0
                
                if results?.count > 0 {
                    for result in results as! [HKQuantitySample] {
                        steps += result.quantity.doubleValue(for: HKUnit.count())
                    }
                    
                    weekSteps = Int(steps)
                                        
                }
            }
            
            healthStore.execute(query)
            
        }
    }
        
        
}
