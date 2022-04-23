//
//  HistoryView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/22/22.
//

import SwiftUI

struct CalculationRow: View {
    
    let calculation: Calculation
    
    var body: some View {
        
        HStack(alignment: .center) {
            VStack {
                Text("Full Price")
                Text(calculation.fullPrice ?? "$0.00")
            }
            
            Spacer()
            
            VStack {
                Text("Discount")
                Text("\(calculation.discountPercentage)%")
            }
            
            Spacer()
            
            VStack {
                Text("New Total")
                Text("$\(calculation.newTotal, specifier: "%. 2f")")
                
            }
            
        }
    }
}

struct HistoryView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Calculation.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Calculation.fullPrice, ascending: true),
        ])
    
    var calculations: FetchedResults<Calculation>
    
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(calculations, id: \.fullPrice) {
                    CalculationRow(calculation: $0)
                }
                .onDelete(perform: deleteCalculation)
            }
            .navigationBarTitle(Text("History"))
        }
    }
    
    func deleteCalculation(at offsets: IndexSet) {
        offsets.forEach { index in
            let calculation = self.calculations[index]
            self.managedObjectContext.delete(calculation)
        }
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


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
