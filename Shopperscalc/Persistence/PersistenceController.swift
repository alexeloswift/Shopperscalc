//
//  PersistenceController.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/23/22.
//

import SwiftUI
import CoreData

class PersistenceController: ObservableObject {
    
    // Storage for Core Data
    let container: NSPersistentContainer
    
    // A test configuration for SwiftUI previews
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Calculations")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
            // Handles changes & merges to updated versions of a data model using light migration
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
    
    static var preview: PersistenceController = {
        let persistenceController = PersistenceController(inMemory: true)
        let viewContext = persistenceController.container.viewContext
        do {
            try persistenceController.createSampleData()
        } catch {
            fatalError("Fatal error creating preview \(error.localizedDescription)")
        }
        return persistenceController
    }()
    
    func createSampleData() throws {
        let viewcontext = container.viewContext
        
        for x in 1...10 {
            let calculation = Calculation(context: viewcontext)
            calculation.fullPrice = "\(x).00"
            calculation.discountPercentage = 20
            calculation.newTotal = Double(x) - (Double(x) * 0.2)
            
        }
        for i in 1...5 {
            let listName = ListName(context: viewcontext)
            listName.listTitle = "Store \(i)"
            listName.date = Date()
            
            for j in 1...10 {
                let listCalculation = ListCalculation(context: viewcontext)
                listCalculation.fullPrice = "$\(j).00"
                listCalculation.discountPercentage = 20
                listCalculation.newTotal = Double(j) - (Double(j) * 0.2)
            }
        }
        try viewcontext.save()
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
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
}






