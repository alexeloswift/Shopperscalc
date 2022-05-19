//
//  ListView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/29/22.
//

import SwiftUI
import CoreData

struct ListView: View {
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject private var viewmodel = ListVM()

    
//    @FetchRequest(
//        entity: Lists.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \Lists.listTitle, ascending: true)
//        ])
//
//    var listName: FetchedResults<Lists>
    
    @FetchRequest(sortDescriptors: []) private var listName: FetchedResults<ListName>
    
    
//    @FetchRequest(
//        entity: ListCalculation.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \ListCalculation.fullPrice, ascending: true)
//        ])
//
//    var listCalculation: FetchedResults<ListCalculation>


    
    var body: some View {
        NavigationView {
            List {
                ForEach(listName, id: \.self) {
                    ListRow(listName: $0)
                }

                    .onDelete(perform: { deleteCalculation(at: $0) })
                    .listRowSeparator(.hidden)

            }

                .navigationTitle("List")
                .navigationBarItems(trailing: Button("Create New List") {
                    viewmodel.isPresented = true
                })

                .sheet(isPresented: $viewmodel.isPresented) {
                        CreateNewListView()
                    
                }
        }
    }
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ListCalculation.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        let persistentContainer = PersistenceController.shared.container
        
        do {
            try persistentContainer.viewContext.executeAndMergeChanges(using: deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func deleteCalculation(at offsets: IndexSet) {
        offsets.forEach { index in
            let list = self.listName[index]
            self.managedObjectContext.delete(list)
        }
        saveContext()
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }

}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
            ListView()
    }
}
