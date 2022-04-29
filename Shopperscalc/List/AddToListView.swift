//
//  AddToListView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/29/22.
//

import SwiftUI

struct AddToListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject private var viewmodel = ListVM()
    
    @FetchRequest(
        entity: ListName.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ListName.listTitle, ascending: true)
        ])
    
    var list: FetchedResults<ListName>
    
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    TextField("Name", text: $viewmodel.listName)
                    
                    
                }
                DisclosureGroup("Date") {
                    DatePicker("", selection: $viewmodel.date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
                
                .navigationTitle("Add List")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                }

                
            }

        }
        
        

    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }

}

struct AddToListView_Previews: PreviewProvider {
    static var previews: some View {
        AddToListView()
    }
}
