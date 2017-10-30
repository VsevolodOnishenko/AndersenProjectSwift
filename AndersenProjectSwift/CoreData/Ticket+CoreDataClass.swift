//
//  Ticket+CoreDataClass.swift
//  AndersenProjectSwift
//
//  Created by macbook on 30.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import Foundation
import CoreData


public class Ticket: NSManagedObject {
    
    private convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Ticket"), insertInto:CoreDataManager.instance.managedObjectContext)
    }
}
