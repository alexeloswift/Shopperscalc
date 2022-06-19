//
//  HistoryView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/22/22.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var persistenceController: PersistenceController
    @StateObject var viewmodel: CalculatorVM
    
    @State var isPresented = false
    
    init(persistenceController: PersistenceController) {
        let viewmodel = CalculatorVM(persistenceController: persistenceController)
        _viewmodel = StateObject(wrappedValue: viewmodel)
    }
    
    var body: some View {
        NavigationView {
            if viewmodel.calculation.isEmpty {
                VStack {
                    Text("You haven't made any calculations yet.")
                    Text("🫠")
                }
                .font(.title3)
                .modifier(AccentIcons())
                .multilineTextAlignment(.center)
            } else {
                List {
                    ForEach(viewmodel.calculation, id: \.fullPrice) {
                        CalculationRow(calculation: $0)
                    }
                    .onDelete { index in
                        viewmodel.deleteCalculation(at: index)
                    }
                    .listRowSeparator(.hidden)
                    .padding(10)
                    .cornerRadius(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10 , style: .continuous)
                            .stroke(.yellow, lineWidth: 0.7)
                            .shadow(color: .yellow, radius: 0.7))
                }
                .navigationBarTitle(Text("History"))
                .toolbar {
                    EditButton()
                        .modifier(AccentIcons())
                }
                .navigationBarItems(trailing: Button(action: {
                    isPresented = true
                }) {
                    Image(systemName: "trash")
                }
                    .modifier(AccentIcons())
                    .alert("Delete All?", isPresented: $isPresented) {
                        Button("Yes", role: .destructive)  {
                            viewmodel.deleteAllCalculations()
                        }
                    }
                )
            }
        }
    }
}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(persistenceController: .preview)
        
    }
}
