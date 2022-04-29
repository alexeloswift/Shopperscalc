//
//  NewTotalViewMod.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/5/22.
//

import SwiftUI

struct NewTotalViewMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title, design: .monospaced))
            .foregroundColor(.primary)
            .frame(width: 300, height: 160, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 17)
                    .stroke(Color.yellow, lineWidth: 3))
        
        
    }
}
