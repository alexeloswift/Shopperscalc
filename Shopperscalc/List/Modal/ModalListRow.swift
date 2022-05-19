//
//  ModalListRow.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 5/1/22.
//

import SwiftUI

struct ModalListRow: View {
    
    var listName: ListName
    
    var body: some View {
        VStack (alignment : .leading) {
            HStack{
                VStack(alignment:.leading) {
                    Text(listName.unwrappedListTitle)
                        .font(.system(size: 20, weight: .bold))
                            }

                Spacer()
                
                VStack (alignment:.leading){
                    Text("Date:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(listName.unwrappedDate, style: .date)")
                }
            }
        }
        .padding(10)
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10 , style: .continuous)
                .stroke(.yellow, lineWidth: 0.7)
                .shadow(color: .yellow, radius: 0.7))
    }
    
}
