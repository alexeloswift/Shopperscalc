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
    @ObservedObject var listName: ListName
    @State var isPresented = false

    init(listName: ListName) {
        self.listName = listName
        let viewmodel = ViewModel(persistenceController: PersistenceController(), listName: listName)
        _viewmodel = StateObject(wrappedValue: viewmodel)
    }
    
    var body: some View {
        if viewmodel.listName.listCalculationsContainer.isEmpty {
            listCalculationContainerEmpty
        } else {
            listCalculationContainerData
            .navigationTitle(listName.unwrappedListTitle)
        }
    }
    
//    BODY COMPONENTS
    
    private var listCalculationContainerEmpty: some View {
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
    }
    
    private var listCalculationContainerData: some View {
        List {
            ForEach(viewmodel.listName.listCalculationsContainer, id: \.fullPrice) { item in
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
