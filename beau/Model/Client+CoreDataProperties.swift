//
//  Client+CoreDataProperties.swift
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

extension Client {

    @NSManaged var clientEmail: String?
    @NSManaged var clientName: String?
    @NSManaged var gotScoreFor: Score?
    @NSManaged var gotDetail: ClientDetail?

}
