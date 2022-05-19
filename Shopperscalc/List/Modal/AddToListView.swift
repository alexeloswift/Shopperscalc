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
    
//    @FetchRequest(
//        entity: Lists.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \Lists.listTitle, ascending: true)
//        ])
//
//    var listName: FetchedResults<Lists>
    
    @FetchRequest(sortDescriptors: []) private var listName: FetchedResults<ListName>

    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(listName, id: \.self) {
                        ModalListRow(listName: $0)
                            .onTapGesture {
                                !calcViewmodel.price.isEmpty ?
                                addListCalculation(fullPrice: calcViewmodel.price,
                                                   newTotal: calcViewmodel.priceAfterDiscount,
                                                   discountPercentage: Int16(calcViewmodel.discountPercentage)) : nil
                                
                                presentationMode.wrappedValue.dismiss()
                                
                        }
                    }
                }
                .listStyle(.plain)
                
                .navigationTitle("Save To List")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel", role: .destructive) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                
                Button("Create New List") {
                    viewmodel.isPresented = true
                }
                .offset(x: 100)
                .padding()
                .sheet(isPresented: $viewmodel.isPresented) {
                    CreateNewListView()
                }
            }
        }
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
