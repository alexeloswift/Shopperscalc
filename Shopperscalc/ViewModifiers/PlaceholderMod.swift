//
//  PlaceholderMod.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/27/22.
//

import SwiftUI

struct PlaceholderMod: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            if showPlaceHolder {
                Text(placeholder)
                    .opacity(0.5)
                    .multilineTextAlignment(.center)
            }
            content
        }
    }
}

