//
//  ShopperscalcApp.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 3/31/22.
//

import SwiftUI

@main
struct ShopperscalcApp: App {
    
    @StateObject var persistenceController: PersistenceController
    @StateObject var viewmodel: CalculatorVM

    
    
    
    init() {
        self._viewmodel = StateObject(wrappedValue: CalculatorVM())
        
        let persistenceController = PersistenceController()
        _persistenceController = StateObject(wrappedValue: persistenceController)
    }
    
    var body: some Scene {
        WindowGroup {
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(viewmodel)
                .environmentObject(persistenceController)
        }
    }
}
