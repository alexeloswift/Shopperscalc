//
//  ListVM.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/29/22.
//

import SwiftUI
import CoreData

class ListVM: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    
//    extension AddToListView {
//
//        class ViewModel: ObservableObject {

//
//            init(listName: ListName, listCalculation: ListCalculation) {

//            }
//        }
//
//    }
    
    
    

    @Published var listName: String = ""
    
//    @Published var sortType: SortType = .alphabetical
    @Published var isPresented = false
//    @Published var searched = ""
    @Published var date = Date()
    
    let persistenceController: PersistenceController
    
    let listNameController: NSFetchedResultsController <ListName>
    @Published var listNames = [ListName]()
    
    init(persistenceController: PersistenceController) {
        

        
        self.persistenceController = persistenceController
        let request: NSFetchRequest<ListName> = ListName.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ListName.date, ascending: false)]
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
    
//    func addList(list: ListModel) {
//        lists.append(list)
//    }
//    
//    func removeList(at offsets: IndexSet) {
//        lists.remove(atOffsets: offsets)
//    }
//    
//    func sort(){
//        
//        switch sortType {
//        case .alphabetical :
//            lists.sort(by: { $0.listName < $1.listName })
//        case .date :
//            lists.sort(by: { $0.date > $1.date })
//        }
//    }
}

