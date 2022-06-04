//
//  ListCalculationsView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/30/22.
//

import SwiftUI
import CoreData

struct ListCalculationsView: View {
    
    @StateObject var viewmodel: ViewModel
    @State var isPresented = false
    
    init(listName: ListName) {
        let viewmodel = ViewModel(listName: listName)
        _viewmodel = StateObject(wrappedValue: viewmodel)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewmodel.listName.listCalculationsCore) { item in
                    ListCalculationRow(listCalculation: item)
                    
                }
//                .onDelete(perform: )
                .listRowSeparator(.hidden)
                .padding(10)
                .cornerRadius(10)
                .background(
                    RoundedRectangle(cornerRadius: 10 , style: .continuous)
                        .stroke(.yellow, lineWidth: 0.7)
                        .shadow(color: .yellow, radius: 0.7))
                
            }
            
            .navigationBarHidden(true)
            .toolbar {
                EditButton()
                    .modifier(AccentIcons())
            }
            .navigationBarItems(trailing: Button(action: {
                isPresented = true
            }) {
                Image(systemName: "trash")
            }
                .modifier(AccentIcons())
                .alert("Delete All?", isPresented: $isPresented) {
                    Button("Yes", role: .destructive)  {
//                        deleteAll()
                        
                    }
                }
            )
        }
    }
    
}

//struct ListCalculationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListCalculationsView(listName: ListName.exampleCalc)
//    }
//}


extension ListCalculationsView {
    
    class ViewModel: ObservableObject {
        let listName: ListName
        
        init(listName: ListName) {
            self.listName = listName
        }
    }
    
}
