//
//  ListRow.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/29/22.
//

import SwiftUI

struct ListRow: View {
    
    var listName: ListName
    
    
    
    var body: some View {
        VStack (alignment : .leading){
            HStack{
                VStack(alignment:.leading) {
                    Text(listName.listTitle ?? "")
                        .font(.system(size: 20, weight: .bold))
                        .background(NavigationLink("", destination: ListCalculationsView()).opacity(0))
                }
                
                Spacer()
                
                VStack (alignment:.leading){
                    Text("Date:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(listName.date ?? Date() , style: .date)
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




