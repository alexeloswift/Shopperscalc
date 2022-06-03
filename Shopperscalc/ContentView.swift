//
//  ContentView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 3/31/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var viewmodel: CalculatorVM
    @EnvironmentObject var persistenceController: PersistenceController
    @EnvironmentObject var viewmodel1: ListCalculationsView.ViewModel

    
//    @State private var num = 0
        
    var body: some View {
        
//        FloatingTabbar(selected: $num)
        TabView {
            CalculatorView()
                .tabItem {
                    Label("Calculator", systemImage: "list.dash")
                }
            ListView(viewmodel: ListVM(persistenceController: persistenceController))
                .tabItem {
                    Label("List", systemImage: "square.and.pencil")
                }
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }

        }
        .environmentObject(viewmodel)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(CalculatorVM())
//    }
//}
