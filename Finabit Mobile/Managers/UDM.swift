//
//  UDM.swift
//  Finabit Mobile
//
//  Created by Hivzi on 12.3.22.
//

import Foundation

class UDM {
    static let shared = UDM()
    
    let defaults = UserDefaults()
    let del: Void = UserDefaults.resetStandardUserDefaults()
    
    func getDepartmentID() -> String? {
        
        let departmentID = defaults.value(forKey: "defaultDepartment") as? String
            
        return departmentID
    }
    
}
