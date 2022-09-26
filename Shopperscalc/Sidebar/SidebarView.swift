//
//  SidebarView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 9/26/22.
//

import SwiftUI

struct SidebarView: View {
    @Binding var isSidebarVisible: Bool
    var body: some View {
        if isSidebarVisible {
            Text("Shopperscalc")
                .bold()
                .font(.largeTitle)
                .background(.purple)
        
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(isSidebarVisible: .constant(true))
    }
}
