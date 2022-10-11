//
//  CalculationRow.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/23/22.
//

import SwiftUI

struct CalculationRow: View {
    
    let calculation: Calculation
    
    var body: some View {
        
        VStack(alignment: .center) {
            Text("New Total")
            Text("$\(calculation.newTotal, specifier: "%. 2f")")
                .font(.title2)
            
            HStack(alignment: .center) {
                VStack {
                    Text("Discount")
                    Text("\(calculation.discountPercentage)%")
                        .foregroundColor(Color.blue)
                }
                
                Spacer()
                
                VStack {
                    Text("Full Price")
                    HStack {
                        Text("$")
                            .offset(x: 7)
                        Text(calculation.fullPrice ?? "$0.00")
                    }
                    .foregroundColor(Color.red)
                }
            }
        }
    }
}





