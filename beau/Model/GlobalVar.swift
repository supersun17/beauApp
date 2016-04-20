//
//  File.swift
//  beau
//
//  Created by Ming Sun on 4/6/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit

public struct GlobalVar {
    static let apiUrl = "https://beau-backend.herokuapp.com"
    static let buttonRadius = CGFloat(5)
    
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
