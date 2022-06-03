//
//  ListCalculationRow.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/30/22.
//

import SwiftUI

struct ListCalculationRow: View {
    
    @ObservedObject var listCalculation: ListCalculation
    @StateObject var viewmodel: ViewModel
    
    
    
    var body: some View {
        
        VStack(alignment: .center) {
            Text("New Total")
                Text("$\(listCalculation.newTotal, specifier: "%. 2f")")
            .font(.title2)
            
            HStack(alignment: .center) {
                VStack {
                    Text("Discount")
                    Text("\(listCalculation.discountPercentage)%")
                        .foregroundColor(Color.blue)
                }
                
                Spacer()
                
                VStack {
                    Text("Full Price")
                    HStack {
                        Text("$")
                            .offset(x: 7)
                        Text(listCalculation.unwrappedFullPrice)
                    }
                    .foregroundColor(Color.red)
                    
                }
            }
        }
    }
    
    init(listCalculation: ListCalculation) {
        let viewmodel = ViewModel(listCalculation: listCalculation)
        _viewmodel = StateObject(wrappedValue: viewmodel)
        
        self.listCalculation = listCalculation
    }
}

extension ListCalculationRow {
    
    class ViewModel: ObservableObject {
//        let listName: ListName
        let listCalculation: ListCalculation
        
        init(listCalculation: ListCalculation) {
//            self.listName = listName
            self.listCalculation = listCalculation
        }
    }
    
}

