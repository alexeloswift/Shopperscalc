//
//  AddToListView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/29/22.
//

import SwiftUI

struct AddToListView: View {
    
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
                                viewmodel.addListCalculationToList(to: item,
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
}

//struct AddToListView_Previews: PreviewProvider {

//    static var previews: some View {
//        AddToListView(presentationMode: , viewmodel: ListVM.init(persistenceController: PersistenceController.preview), calcViewmodel: CalculatorVM(persistenceController: PersistenceController.preview))
//    }
//}


