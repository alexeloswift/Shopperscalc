//
//  ContentView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 3/31/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var viewmodel: CalculatorVM
    
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        
        TabView {
            CalculatorView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tabItem {
                    Label("Calculator", systemImage: "list.dash")
                }
            
            HistoryView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tabItem {
                    Label("History", systemImage: "square.and.pencil")
            }
        }
        .environmentObject(viewmodel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CalculatorVM())
    }
}
