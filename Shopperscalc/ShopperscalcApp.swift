//
//  ShopperscalcApp.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 3/31/22.
//

import SwiftUI

@main
struct ShopperscalcApp: App {
    
    @StateObject var viewmodel: CalculatorVM
    
    let persistenceController = PersistenceController.shared
    
    
    init() {
        self._viewmodel = StateObject(wrappedValue: CalculatorVM())
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(viewmodel)
        }
    }
}
