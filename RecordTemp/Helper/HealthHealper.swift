//
//  HealthHealper.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/09.
//

import Foundation
import SwiftUI
import HealthKit


struct HealthHelper {
    
    static let instance = HealthHelper()
    
    //MARK: FUNCTIONS
    func uploadBodyTemperature(bodyTmp: Double){
        setupHealthKit { (success, healthStore) in
            if success{
                let myunit: HKUnit! = HKUnit.degreeCelsius()
                let quantity: HKQuantity = HKQuantity(unit: myunit, doubleValue: bodyTmp)
                
                let hkQunatityType: HKQuantityType = HKObjectType.quantityType(forIdentifier: .bodyTemperature)!
                
                var quantitySample = HKQuantitySample(type: hkQunatityType, quantity: quantity, start: Date(), end: Date())
                
                healthStore.save(quantitySample) { (success, error) in
                    if !success{
                        // Error handling
                        print("Error can't save")
                    }else{
                        // Success
                        print("Success")
                    }
                }
            }
        }
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func setupHealthKit(handler: @escaping (_ success: Bool, _ healthStore: HKHealthStore) -> ()){
        availableHealthKit { (success) in
            if success{
                //create HealthKit instance
                let healthStore: HKHealthStore = HKHealthStore()
                requestPermissionFromUser(healthStore: healthStore) { (success) in
                    if success{
                        handler(true, healthStore)
                    }
                }
            }
        }
    }

    private func availableHealthKit(handler: @escaping (_ success: Bool ) -> ()){
        if HKHealthStore.isHealthDataAvailable(){
            handler(true)
        }else{
            print("HealthKit is not available")
            handler(false)
        }
    }
    
    private func requestPermissionFromUser(healthStore: HKHealthStore, handler: @escaping (_ success: Bool) -> ()){
        // only bodyTemperature
        let allTypes = Set([HKObjectType.quantityType(forIdentifier: .bodyTemperature)!])
        
        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            if !success{
                // Handle error here.
                print("Can't Request Permission From User")
                handler(false)
            }else{
                handler(true)
            }
        }
    }
}
