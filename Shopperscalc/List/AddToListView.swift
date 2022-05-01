//
//  AddToListView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/29/22.
//

import SwiftUI

struct AddToListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var viewmodel = ListVM()
    @ObservedObject private var calcViewmodel = CalculatorVM()
    
    @FetchRequest(
        entity: ListName.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ListName.listTitle, ascending: true)
        ])
    
    var listName: FetchedResults<ListName>
    
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    TextField("Name", text: $viewmodel.listName)
                    
                    DisclosureGroup("Date") {
                        DatePicker("", selection: $viewmodel.date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                    Form {
                    List {
                        ForEach(listName, id: \.listTitle) {
                            ListRow(listName: $0)
                        }
                        }
                    }                    
                    
                    
                }

                
                .navigationTitle("Add To List")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel", role: .destructive) {
                            presentationMode.wrappedValue.dismiss()
                            
                        }
                        
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save", role: .none) {
                            
                            addListName(listName: viewmodel.listName)
                            
                            addListCalculation(fullPrice: calcViewmodel.price, newTotal: calcViewmodel.priceAfterDiscount, discountPercentage: Int16(calcViewmodel.discountPercentage))
                            
                            presentationMode.wrappedValue.dismiss()

                            
                        }
                    }
                }
            }
        }
    }
    
    func addListName(listName: String) {
        let newListName = ListName(context: managedObjectContext)
        
        newListName.listTitle = listName
    }
    
    func addListCalculation(fullPrice: String, newTotal: Double, discountPercentage: Int16) {
        let newListCalculation = ListCalculation(context: managedObjectContext)
        
        newListCalculation.newTotal = newTotal
        newListCalculation.fullPrice = fullPrice
        newListCalculation.discountPercentage = discountPercentage
        
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

struct AddToListView_Previews: PreviewProvider {
    static var previews: some View {
        AddToListView()
    }
}
