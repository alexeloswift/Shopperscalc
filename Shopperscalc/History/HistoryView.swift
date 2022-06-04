//
//  HistoryView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/22/22.
//

import SwiftUI
import CoreData


struct HistoryView: View {
    
    @StateObject var viewmodel: CalculatorVM
    
    @State var isPresented = false
    
    init(persistenceController: PersistenceController) {
        let viewmodel = CalculatorVM(persistenceController: persistenceController)
        _viewmodel = StateObject(wrappedValue: viewmodel)
    }
    
    var body: some View {
        NavigationView {
            List {
                Text("This is the calculation history!")
                    .font(.subheadline)
                    .modifier(AccentIcons())
                    .multilineTextAlignment(.center)
                
                ForEach(viewmodel.calculation, id: \.fullPrice) {
                    CalculationRow(calculation: $0)

                }
//                .onDelete(perform: deleteCalculation)
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
//                        deleteAll()
                        
                    }
                }
            )
        }
    }
    
    

}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(persistenceController: .preview)

    }
}
