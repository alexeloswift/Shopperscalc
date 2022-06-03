//
//  ListRow.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/29/22.
//

import SwiftUI

struct ListRow: View {
    
    @ObservedObject var listName: ListName
//    @ObservedObject var viewmodel: ListCalculationsView.ViewModel
//    @ObservedObject var listCalulation: ListCalculation
    
    
    
    var body: some View {
        VStack (alignment : .leading){
            HStack{
                VStack(alignment:.leading) {
                    Text(listName.unwrappedListTitle)
                        .font(.system(size: 20, weight: .bold))
                        .background(NavigationLink("", destination: ListCalculationsView(listName: listName)).opacity(0))
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

extension ListRow {
    
    class ViewModel: ObservableObject {
        let listName: ListName
        
        init(listName: ListName) {
            self.listName = listName
        }
    }
    
}




