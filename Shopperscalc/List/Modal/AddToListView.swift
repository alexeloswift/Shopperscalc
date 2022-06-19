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

        if viewmodel.listNames.isEmpty {
            
        ScrollView {
            VStack {

                Image("shoppingcalcpic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100, alignment: .center)
                Spacer()
                Text("You havent created any list yet 🤭")
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
            .padding(.top, 100)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .destructive) {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .tint(Color.yellow)

                }
            }

        }
        
    } else {
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
                                
                            }}
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
                        .tint(Color.yellow)

                    }
                }
            }
        }
    }
}

struct AddToListView_Previews: PreviewProvider {

    static var previews: some View {
        AddToListView(viewmodel: ListVM(persistenceController: PersistenceController()), calcViewmodel: CalculatorVM(persistenceController: PersistenceController()))
    }
}


