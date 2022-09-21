//
//  AddToListView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/29/22.
//

import SwiftUI

struct AddToListView: View {
    
    @ObservedObject var viewmodel: ListVM
    @ObservedObject var calcViewmodel: CalculatorVM
    @State private var animationState: AnimationState = .normal
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            if viewmodel.listNames.isEmpty {
                listDataEmpty
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.spring()) {
                                animationState = .expand
                                DispatchQueue.main.asyncAfter (deadline: .now() + 0.5) {
                                    withAnimation(.spring()) {
                                        animationState = .compress
                                        DispatchQueue.main.asyncAfter (deadline: .now() + 0.3) {
                                            withAnimation(.spring()) {
                                                animationState = .normal
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    listData
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
    
//    BODY COMPONENTS
    
    private var listDataEmpty: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            VStack {
                Image("error")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(calculate())
                
                Text("YOU HAVENT CREATED ANY LISTS YET.")
                    .padding()
                Text("😱")
                    .scaleEffect(calculateEmoji())
                Text("Open the list tab, from there you will be able to create a list. Once you have a list created you will be able to come back to the calculations tab and add calculations to any list.")
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .padding(.bottom, 100)
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
    
    private var listData: some View {
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
                    .listRowSeparator(.hidden)
                }
            }
        }
    
//    ANIMATION
    
    func calculate() -> Double {
        switch animationState{
        case .normal:
            return 0.35
        case .compress:
            return 0.18
        case .expand:
            return 0.8
        }
    }
    
    func calculateEmoji() -> Double {
        switch animationState{
        case .normal:
            return 2
        case .compress:
            return 0.5
        case .expand:
            return 3.5
        }
    }
}

struct AddToListView_Previews: PreviewProvider {
    static var previews: some View {
        AddToListView(viewmodel: ListVM(persistenceController: PersistenceController()), calcViewmodel: CalculatorVM(persistenceController: PersistenceController()))
    }
}


