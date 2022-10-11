//
//  CalculatorView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/5/22.
//

import SwiftUI

struct CalculatorView: View {
    
    @StateObject var listViewmodel: ListVM
    @StateObject var viewmodel: CalculatorVM
    @State private var isPresented = false
    @State var isSidebarOpen = false
    
    let discountPercentages = 1..<101
    
    init(persistenceController: PersistenceController) {
        let viewmodel = CalculatorVM(persistenceController: persistenceController)
        _viewmodel = StateObject(wrappedValue: viewmodel)
        let listViewmodel = ListVM(persistenceController: persistenceController)
        _listViewmodel = StateObject(wrappedValue: listViewmodel)
    }
    
//    MARK: - BODY QUICK VIEW
    
    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader { geo in
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack {
                            total
                            discount(geo: geo)
                            Spacer()
                                .padding()
                            buttons
                            Spacer()
                                .padding(.bottom, 100)
                        }
                    }
                }
                .padding(.top, 25)
                .toolbar {
                    hideKeyboard
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        sidebar
                    }
                }
                .toolbar {
                    addToListButton
                }

                .sheet(isPresented: $isPresented) {
                    AddToListView(viewmodel: listViewmodel, calcViewmodel: viewmodel)
                }

            }
            SidebarView(isSidebarVisible: $isSidebarOpen)
        }
    }
    
//    MARK: - BODY COMPONENTS

    private var header: some View {
        Image("shoppingcalcpic")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50, alignment: .center)
    }
    private var total: some View {
        VStack {
            VStack {
                Text("New Total")
                Text("$\(viewmodel.priceAfterDiscount, specifier: "%. 2f")")
                    .accessibilityLabel("Full Price")
                    .padding(1)
            }
        }
        .modifier(NewTotalViewMod())
        .padding()
    }
    
    private func discount(geo: GeometryProxy) -> some View {
        HStack {
            VStack {
                Text("Discount")
                
                Divider()
                    .frame(width: 100)
                
                Picker("", selection: $viewmodel.discountPercentage) {
                    ForEach(discountPercentages, id: \.self) {
                        Text("\($0) %")
                    }
                }
            }
            .modifier(SmallViewsMod())
            
            VStack {
                Text("Full Price")
                
                Divider()
                    .frame(width: 100)
                
                TextField(viewmodel.price, text: $viewmodel.price)
                    .modifier(PlaceholderMod(showPlaceHolder: viewmodel.price.isEmpty, placeholder: "$0.00"))
                    .keyboardType(.decimalPad)
                    .accessibilityLabel("Full Price")
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        viewmodel.reset()
                    }
            }
            .padding(.bottom, 5)
            .modifier(SmallViewsMod())
        }
        .frame(width: geo.size.width, height: 100, alignment: .center)
    }
    
    private var clearButton: some View {
        Button("clear", action: viewmodel.reset)
            .font(.system(.body, design: .monospaced))
            .font(.title3)
            .padding(3)
            .foregroundColor(.primary)
            .padding(10)
            .overlay(
                Capsule()
                    .stroke(Color(UIColor.systemYellow).opacity(0.7), lineWidth: 3))
    }
    
    private var calcButton: some View {
        Button("calculate") {
            viewmodel.presentCalculation()
            
            !viewmodel.price.isEmpty ? viewmodel.addCalculation(
                fullPrice: viewmodel.price,
                newTotal: viewmodel.priceAfterDiscount,
                discountPercentage: Int16(viewmodel.discountPercentage)) : nil
        }
        .font(.system(.body, design: .monospaced))
        .font(.title3)
        .padding(3)
        .foregroundColor(.primary)
        .padding(10)
        .overlay(
            Capsule()
                .stroke(Color(UIColor.systemYellow).opacity(0.7), lineWidth: 3))
    }
    
    private var buttons: some View {
        HStack {
            clearButton
            calcButton
        }
    }
    
    private var addToListButton: some View {
        Button("Add to List") {
            isPresented = true
            
            !viewmodel.price.isEmpty ? viewmodel.addListCalculation(
                fullPrice: viewmodel.price,
                newTotal: viewmodel.priceAfterDiscount,
                discountPercentage: Int16(viewmodel.discountPercentage)) : nil
        }
        .tint(Color.yellow)
    }
    
    private var hideKeyboard: ToolbarItem<(), some View> {
        ToolbarItem(placement: .keyboard) {
            Button(action: {
                hideKeyboard()
            }, label: {
                Image(systemName: "keyboard.chevron.compact.down").modifier(AccentIcons())})
        }
    }
    
    private var sidebar: some View {
            Button {
                isSidebarOpen.toggle()
            } label: {
                Image("shoppingcalcpic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35, alignment: .trailing)

                    
            }
    }
    
    
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(persistenceController: .preview)
            .preferredColorScheme(.light)
    }
}
