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
    // 1.
    @FetchRequest(
        // 2.
        entity: Calculation.entity(),
        // 3.
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Calculation.fullPrice, ascending: true),
        ]
        //,predicate: NSPredicate(format: "genre contains 'Action'")
        // 4.
    ) var calculations: FetchedResults<Calculation>
    
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
        // 1.
        offsets.forEach { index in
            // 2.
            let calculation = self.calculations[index]
            
            // 3.
            self.managedObjectContext.delete(calculation)
        }
        
        // 4.
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
