//
//  PersistenceController.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/23/22.
//

import SwiftUI
import CoreData

class PersistenceController {
    
    static let shared = PersistenceController()
    
    // Storage for Core Data
    let container: NSPersistentContainer
    
    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController()
        return controller
    }()
    
    init() {
        
        container = NSPersistentContainer(name: "Calculations")
        
//        /*add necessary support for migration*/
//         let description = NSPersistentStoreDescription()
//         description.shouldMigrateStoreAutomatically = true
//         description.shouldInferMappingModelAutomatically = true
//         container.persistentStoreDescriptions =  [description]
//         /*add necessary support for migration*/
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
    
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("error saving changes")
            }
        }
    }
}






