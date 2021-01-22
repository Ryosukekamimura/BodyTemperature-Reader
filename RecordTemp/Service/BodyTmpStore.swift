//
//  BodyTmpStore.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/22.
//

import RealmSwift
import SwiftUI

class BodyTmpStore: ObservableObject {
    
    // Data
    @Published var id: Int = 0
    @Published var bodyTemperature: String = ""
    @Published var dateCreated: Date = Date()
    
    // Fetch Data
    @Published var bodyTmps: [BodyTmp] = []
    
    init() {
        fetchData()
    }
    
    
    
    // Fetching Data
    func fetchData() {
        guard let dbRef = try? Realm() else { return }
        
        let results = dbRef.objects(BodyTmp.self)
        
        // Display results
        self.bodyTmps = results.compactMap({ (bodyTmp) -> BodyTmp? in
            return bodyTmp
        })
        
    }
    
    // Adding New Data
    func addData() {
        let bodyTmp = BodyTmp()
        bodyTmp.id = id
        bodyTmp.bodyTemperature = bodyTemperature
        bodyTmp.dateCreated = dateCreated
        
        // Get Reference
        guard let dbRef = try? Realm() else { return }
        
        // Writing Data
        try? dbRef.write {
            dbRef.add(bodyTmp)
            
            // Updating UI
            fetchData()
        }
    }
    
    // Setting And Clearing Data
    func setUpInitialData() {
        // Updation
    }
    
    func deInitData() {
        bodyTemperature = ""
    }
}

