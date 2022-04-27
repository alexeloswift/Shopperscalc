//
//  HistoryView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/22/22.
//

import SwiftUI
import CoreData


struct HistoryView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Calculation.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Calculation.fullPrice, ascending: true),
        ])
    
    var calculations: FetchedResults<Calculation>
    
    let persistentContainer = PersistenceController.shared
    
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
            .toolbar {
                EditButton()
                    .modifier(AccentIcons())
            }
            .navigationBarItems(trailing: Button(action: {
                isPresented = true
                //                TODO: Insert delete all code here
                

                
                
            }) {
                Image(systemName: "trash")
            }
                .modifier(AccentIcons())
                .alert("Would you like to delete all calculations?", isPresented: $isPresented) {
                    Button("Yes", role: .destructive)  {
                        deleteAll()
                        
                    }
                }
            )
        }
    }
    

    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Calculation.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        let persistentContainer = PersistenceController.shared.container

        do {
            try persistentContainer.viewContext.executeAndMergeChanges(using: deleteRequest)
        } catch let error as NSError {
            print(error)
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
