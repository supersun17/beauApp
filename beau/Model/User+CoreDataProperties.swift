//
//  User+CoreDataProperties.swift
//  beau
//
//  Created by Ming Sun on 4/13/16.
//  Copyright © 2016 UDECE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var email: String?
    @NSManaged var username: String?

}
