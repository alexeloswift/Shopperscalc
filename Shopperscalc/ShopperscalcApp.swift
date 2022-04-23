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
    
    init() {
        self._viewmodel = StateObject(wrappedValue: CalculatorVM())
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewmodel)
        }
    }
}
