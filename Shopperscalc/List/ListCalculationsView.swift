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
    @ObservedObject var listViewModel = ListVM(persistenceController: PersistenceController())
    @State var isPresented = false
    @ObservedObject var listName: ListName
    
    
    init(listName: ListName) {
        self.listName = listName
        let viewmodel = ViewModel(persistenceController: PersistenceController(), listName: listName)
        _viewmodel = StateObject(wrappedValue: viewmodel)
    }
    
    var body: some View {
        if viewmodel.listName.listCalculationsCore.isEmpty {
            ScrollView {
                VStack {
                    Image("shoppingcalcpic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100, alignment: .center)
                    Spacer()
                    Text("You havent saved any calculations to this list yet 🤭")
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                }
            }
        } else {
            List {
                ForEach(viewmodel.listName.listCalculationsCore, id: \.fullPrice) { item in
                    ListCalculationRow(listCalculation: item)
                }
                .listRowSeparator(.hidden)
                .padding(10)
                .cornerRadius(10)
                .background(
                    RoundedRectangle(cornerRadius: 10 , style: .continuous)
                        .stroke(.yellow, lineWidth: 0.7)
                        .shadow(color: .yellow, radius: 0.7))
            }
            .navigationTitle(listName.unwrappedListTitle)
        }
    }
}

struct ListCalculationsView_Previews: PreviewProvider {
    static var previews: some View {
        ListCalculationsView(listName: ListName.example)
    }
}

extension ListCalculationsView {
    class ViewModel: ObservableObject {
        let listName: ListName
        let persistenceController: PersistenceController
        
        init(persistenceController: PersistenceController, listName: ListName) {
            self.listName = listName
            self.persistenceController = persistenceController
        }
    }
}
