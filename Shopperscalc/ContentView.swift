//
//  ContentView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 3/31/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewmodel: CalculatorVM
    
    var body: some View {
        CalculatorView()
            .environmentObject(viewmodel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CalculatorVM())
    }
}
