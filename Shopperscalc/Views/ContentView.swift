//
//  ContentView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 3/31/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var persistenceController: PersistenceController
    
    var body: some View {
        TabView {
            CalculatorView(persistenceController: persistenceController)
                .tabItem {
                    Label("Calculator", systemImage: "plus.slash.minus")
                }
                .tabViewStyle(.automatic)
            HistoryView(persistenceController: persistenceController)
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            ListView(persistenceController: persistenceController)
                .tabItem {
                    Label("List", systemImage: "list.dash")
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PersistenceController())
    }
}
