//
//  ListVM.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/29/22.
//

import SwiftUI
import CoreData

class ListVM: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    

    @Published var listName: String = ""
    @Published var isPresented = false
    @Published var date = Date()
    
    let persistenceController: PersistenceController
    
    let listNameController: NSFetchedResultsController <ListName>
    @Published var listNames = [ListName]()
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        let request: NSFetchRequest<ListName> = ListName.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ListName.date, ascending: true)]
        listNameController = NSFetchedResultsController(fetchRequest: request,
                                                        managedObjectContext: persistenceController.container.viewContext,
                                                        sectionNameKeyPath: nil,
                                                        cacheName: nil)
        super.init()
        listNameController.delegate = self
        do {
            try listNameController.performFetch()
            listNames = listNameController.fetchedObjects ?? []
        } catch {
            print("Failed fetch")
        }
    }
    
    func addListName(listName: String) {
        let newListName = ListName(context: persistenceController.container.viewContext)
        newListName.listTitle = listName
        persistenceController.save()
    }
    
    func addListCalculationToList(to listName: ListName, fullPrice: String, newTotal: Double, discountPercentage: Int16) {
        let listCalculation = ListCalculation(context: persistenceController.container.viewContext)
        listCalculation.listName = listName
        listCalculation.newTotal = newTotal
        listCalculation.fullPrice = fullPrice
        listCalculation.discountPercentage = discountPercentage
        
        persistenceController.save()
        
    }
    
    func deleteCalculation(at offsets: IndexSet, from listName: ListName) {
        let allItems = listName.listCalculationsCore
        for offset in offsets {
            let item = allItems[offset]
            persistenceController.delete(item)
        }
        persistenceController.save()
    }
    
    //    func deleteAll() {
    //        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ListCalculation.fetchRequest()
    //        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    //
    //        let persistentContainer = PersistenceController.shared.container
    //
    //        do {
    //            try persistentContainer.viewContext.executeAndMergeChanges(using: deleteRequest)
    //        } catch let error as NSError {
    //            print(error)
    //        }
    //    }

//    func deleteAll() {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ListCalculation.fetchRequest()
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        
//        let persistentContainer = PersistenceController.shared.container
//        
//        do {
//            try persistentContainer.viewContext.executeAndMergeChanges(using: deleteRequest)
//        } catch let error as NSError {
//            print(error)
//        }
//    }


}

