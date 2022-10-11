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
    @Published var listNames = [ListName]()
    @Published var date = Date()
    
    let persistenceController: PersistenceController
    let listNameController: NSFetchedResultsController <ListName>
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        let listNameRequest: NSFetchRequest<ListName> = ListName.fetchRequest()
        listNameRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ListName.listTitle, ascending: true)]
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
    
    func resetListName() {
        listName = ""
    }
}

