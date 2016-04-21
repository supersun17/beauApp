//
//  Score+CoreDataProperties.swift
//  beau
//
//  Created by Ming Sun on 4/21/16.
//  Copyright © 2016 UDECE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Score {

    @NSManaged var score: NSNumber?
    @NSManaged var clientEmail: NSManagedObject?
    @NSManaged var userEmail: User?

}
