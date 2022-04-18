//
//  CalculatorView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/5/22.
//

import SwiftUI

struct CalculatorView: View {
    
    let discountPercentages = 1..<101
    
    @EnvironmentObject private var viewmodel: CalculatorVM
    
    
    var body: some View {
        
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    VStack {
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
                        
                        HStack {
                            VStack {
                                Text("Discount")
                                
                                Divider()
                                    .frame(width: 100)
                                
                                Picker("Discount Percentage", selection: $viewmodel.discountPercentage) {
                                    ForEach(discountPercentages, id: \.self) {
                                        Text("\($0) %")
                                        
                                    }}
                            }
                            .modifier(SmallViewsMod())
                            
                            VStack {
                                Text("Full Price")
                                
                                Divider()
                                    .frame(width: 100)
                                
                                TextField(viewmodel.price, text: $viewmodel.price)
                                    .modifier(PlaceholderStyle(showPlaceHolder: viewmodel.price.isEmpty, placeholder: "$0.00"))
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
                        
                        Spacer()
                            .padding()
                        
                        HStack {
                            Button("clear", action: viewmodel.reset)
                                .font(.system(.body, design: .monospaced))
                                .font(.title3)
                                .padding(3)
                                .foregroundColor(.primary)
                                .padding(10)
                                .overlay(
                                    Capsule()
                                        .stroke(Color(UIColor.systemYellow).opacity(0.7), lineWidth: 3))
                            
                            Button("calculate", action: viewmodel.presentCalculation)
                                .font(.system(.body, design: .monospaced))
                                .font(.title3)
                                .padding(3)
                                .foregroundColor(.primary)
                                .padding(10)
                                .overlay(
                                    Capsule()
                                        .stroke(Color(UIColor.systemYellow).opacity(0.7), lineWidth: 3))
                            
                        }
                        Spacer()
                            .padding(.bottom, 100)
                    }
                }
            }
            .navigationTitle("Shopperscalc")
            .padding(.top, 50)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button(action: {
                        hideKeyboard()
                    }, label: {
                        Image(systemName: "keyboard.chevron.compact.down").modifier(AccentIcons())})
                }
            }
        }
    }
}



struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .preferredColorScheme(.dark)
            .environmentObject(CalculatorVM())
    }
}
