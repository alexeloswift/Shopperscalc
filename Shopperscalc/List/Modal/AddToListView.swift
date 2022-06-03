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
    
    @ObservedObject var viewmodel: ListVM
    @ObservedObject var calcViewmodel: CalculatorVM

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewmodel.listNames) { item in
                        ModalListRow(listName: item)
                            .onTapGesture {
                                !calcViewmodel.price.isEmpty ?
                                addListCalculationToList(to: item,
                                                         fullPrice: calcViewmodel.price,
                                                         newTotal: calcViewmodel.priceAfterDiscount,
                                                         discountPercentage: Int16(calcViewmodel.discountPercentage)) : print("items not saved")

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
                    CreateNewListView(viewmodel: viewmodel)
                }
            }
        }
    }
    

    
    func addListCalculationToList(to listName: ListName, fullPrice: String, newTotal: Double, discountPercentage: Int16) {
        print("Data Saved")

        let listCalculation = ListCalculation(context: managedObjectContext)
        listCalculation.listName = listName
        listCalculation.newTotal = newTotal
        listCalculation.fullPrice = fullPrice
        listCalculation.discountPercentage = discountPercentage
        

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

//struct AddToListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddToListView()
//    }
//}


