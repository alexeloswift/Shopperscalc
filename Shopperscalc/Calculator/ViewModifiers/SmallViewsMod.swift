//
//  SmallViewsMod.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/5/22.
//

import SwiftUI

struct SmallViewsMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.body, design: .monospaced))
            .foregroundColor(.primary)
            .frame(width: 150, height: 120, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 17)
                    .stroke(Color.yellow, lineWidth: 3))


            }
        }
