//
//  CoreDataManager.swift
//  AndersenProjectSwift
//
//  Created by macbook on 30.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class CoreDataManager {
   
    static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "AndersenProjectSwift")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init(completionClosure: @escaping () -> ()) {
        
        guard let modelURL = Bundle.main.url(forResource: "AndersenProjectSwift", withExtension: "momd") else {
            assertionFailure()
            return
        }
        
        guard let objectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            assertionFailure()
            return
        }
        
        let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = storeCoordinator
        
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        queue.async {
            guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
                else {
                    assertionFailure()
                    return
            }
            
            let storeUrl = docURL.appendingPathComponent("TicketModel.sqlite")
            
            do {
                try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: nil)
                DispatchQueue.main.sync(execute: completionClosure)
            } catch {
                assertionFailure()
            }
        }
        
        //  MARK: - Core Data Saving support
    
        func saveContext () {
            let context = CoreDataManager.persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
        
    }
    
}

