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
    
    @FetchRequest(
        entity: ListName.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ListName.listTitle, ascending: true)
        ])
    
    var listName: FetchedResults<ListName>
    
    @ObservedObject private var viewmodel = ListVM()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewmodel.lists.filter {
                    self.viewmodel.searched.isEmpty ? true : $0.listName.localizedCapitalized.contains(self.viewmodel.searched)} ){ list in
                        ListRow(list: list)
                }
                    .onDelete(perform: {
                        viewmodel.removeList(at: $0)
                    })
            }
            
            
                .navigationTitle("List")
                .navigationBarItems(trailing: Button("add new list") {
                    viewmodel.isPresented = true
                })

                .sheet(isPresented: $viewmodel.isPresented) {
                    NavigationView {
                        AddToListView()
                    }
                }
        }
    }
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ListName.fetchRequest()
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
