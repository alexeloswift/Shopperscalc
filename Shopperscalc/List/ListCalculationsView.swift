//
//  ListCalculationsView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/30/22.
//

import SwiftUI
import CoreData

struct ListCalculationsView: View {
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: ListCalculation.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ListCalculation.fullPrice, ascending: true)
        ])
    
    var listCalculations: FetchedResults<ListCalculation>
    
    @FetchRequest(sortDescriptors: []) private var listName: FetchedResults<ListName>


    
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(listCalculations, id: \.fullPrice) {
                    ListCalculationRow(listCalculation: $0)

                }
                .onDelete(perform: deleteCalculation)
                .listRowSeparator(.hidden)
                .padding(10)
                .cornerRadius(10)
                .background(
                    RoundedRectangle(cornerRadius: 10 , style: .continuous)
                        .stroke(.yellow, lineWidth: 0.7)
                .shadow(color: .yellow, radius: 0.7))

            }
        
            .navigationBarHidden(true)
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
                        deleteAll()
                        
                    }
                }
            )
        }
    }
    
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ListCalculation.fetchRequest()
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
            let calculation = self.listCalculations[index]
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

struct ListCalculationsView_Previews: PreviewProvider {
    static var previews: some View {
        ListCalculationsView()
    }
}
