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
        let listNameRequest: NSFetchRequest<ListName> = ListName.fetchRequest()
        listNameRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ListName.date, ascending: true)]
        listNameController = NSFetchedResultsController(fetchRequest: listNameRequest,
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
        newListName.date = date
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
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController <NSFetchRequestResult>) {
        if let newListNames = controller.fetchedObjects as? [ListName] {
            listNames = newListNames
        }
    }
    
    
    func deleteList(at offsets: IndexSet) {
        let allList = listNames
        for offset in offsets {
            let list = allList[offset]
            persistenceController.delete(list)
        }
        persistenceController.save()
    }

    
//    func deleteCalculation(at ofsets: IndexSet) {
//        ofsets.forEach { index in
//            let listCalculation =
//            
//        }
//    }

    
//    func deleteCalculation(at offsets: IndexSet) {
//        offsets.forEach { index in
//            let list = self.listName[index]
//            self.managedObjectContext.delete(list)
//        }
//        saveContext()
//    }
    
//    func deleteList(at offsets: IndexSet) {
//        offsets.forEach { index in
//            let list = listNames[index]
//            persistenceController.delete(list)
//        }
//
//    }
    
//    func deleteCalculation(at offsets: IndexSet) {
//        let allItems =
//        for offset in offsets {
//            let item = allItems[offset]
//            persistenceController.delete(item)
//        }
//        persistenceController.save()
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

