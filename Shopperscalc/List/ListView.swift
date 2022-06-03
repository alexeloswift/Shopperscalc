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
    @ObservedObject var viewmodel: ListVM
    
    
    @FetchRequest(
        sortDescriptors: [])
    private var listName: FetchedResults<ListName>
    
    //    @ObservedObject var listCalculation: ListCalculation
    //    @ObservedObject var listNa: ListName
    //    @ObservedObject var viewmodel1: ListCalculationsView.ViewModel
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewmodel.listNames) { item in
                    ListRow(listName: item)
                }
                .onDelete { offsets in
                    deleteCalculation(at: offsets)
                }
            }
            .listRowSeparator(.hidden)
            .navigationTitle("List")
            .navigationBarItems(trailing: Button("Create New List") {
                viewmodel.isPresented = true
            })
            
            .sheet(isPresented: $viewmodel.isPresented) {
                CreateNewListView(viewmodel: viewmodel)
                
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

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//            ListView()
//    }
//}
