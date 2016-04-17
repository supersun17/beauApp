//
//  File.swift
//  beau
//
//  Created by Ming Sun on 4/6/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import Foundation

public struct GlobalVar {
    static let apiUrl = "https://beau-remote.herokuapp.com/com.beauapp"
    
    
    static func generatUUID() -> String {
        if let UUID = NSUserDefaults.standardUserDefaults().stringForKey("UUID") {
            return UUID
        } else {
            let UUID = NSUUID.init().UUIDString
            NSUserDefaults.standardUserDefaults().setObject(UUID, forKey: "UUID")
            NSUserDefaults.standardUserDefaults().synchronize()
            return UUID
        }
    }
}
