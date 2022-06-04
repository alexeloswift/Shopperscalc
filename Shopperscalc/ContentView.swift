//
//  ContentView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 3/31/22.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var persistenceController: PersistenceController
    
//    @State private var num = 0
        
    var body: some View {
        
//        FloatingTabbar(selected: $num)
        TabView {
            CalculatorView(persistenceController: persistenceController)
                .tabItem {
                    Label("Calculator", systemImage: "list.dash")
                }
            ListView(persistenceController: persistenceController)
                .tabItem {
                    Label("List", systemImage: "square.and.pencil")
                }
            HistoryView(persistenceController: persistenceController)
                .tabItem {
                    Label("History", systemImage: "clock")
                }

        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(CalculatorVM())
//    }
//}
