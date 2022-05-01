//
//  ListCalculationRow.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/30/22.
//

import SwiftUI

struct ListCalculationRow: View {
    
    let listCalculation: ListCalculation
    
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
                        Text(listCalculation.fullPrice ?? "$0.00")
                    }
                    .foregroundColor(Color.red)
                    
                }
            }
        }
    }
}

