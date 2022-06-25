//
//  ListView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/29/22.
//

import SwiftUI
import CoreData

struct ListView: View {
    
    @EnvironmentObject var persistenceController: PersistenceController
    @StateObject var viewmodel: ListVM
    
    init(persistenceController: PersistenceController) {
        let viewmodel = ListVM(persistenceController: persistenceController)
        _viewmodel = StateObject(wrappedValue: viewmodel)
    }
    
    var body: some View {
        
        NavigationView {

            List {
                if viewmodel.listNames.isEmpty {
                    HStack {
                        Image("shoppingcalcpic")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50, alignment: .center)
                        Text("Once you create a list it will be displayed here.")
                    }
                    .multilineTextAlignment(.center)
                } else {

                    ForEach(viewmodel.listNames) { item in
                        ListRow(listName: item)
                    }
                    .onDelete { offsets in
                        viewmodel.deleteList(at: offsets)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("List")
            .navigationBarItems(trailing: Button("Create New List") {
                viewmodel.isPresented = true
            })
            .tint(Color.yellow)
            .sheet(isPresented: $viewmodel.isPresented) {
                CreateNewListView(viewmodel: viewmodel)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(persistenceController: .preview)
    }
}
