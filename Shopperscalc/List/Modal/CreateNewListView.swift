//
//  CreateNewListView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 5/16/22.
//

import SwiftUI

struct CreateNewListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewmodel: ListVM
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                
                VStack {
                    TextField("List Name", text: $viewmodel.listName)
                        .padding()
                        .foregroundColor(.neumorphictextColor)
                        .background(Color.background)
                        .cornerRadius(6)
                        .padding()
                    
                    DatePicker("", selection: $viewmodel.date)
                        .hidden()
                    
                    Button("Save") {
                        viewmodel.addListName(listName: viewmodel.listName)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.title2)
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(.black)
                }
                .onAppear {
                    viewmodel.resetListName()
                }
            }
            .navigationTitle("Save List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .destructive) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save", role: .none) {
                        viewmodel.addListName(listName: viewmodel.listName)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .tint(Color.yellow)
        }
    }
}

struct CreateNewListView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewListView( viewmodel: ListVM(persistenceController: PersistenceController()))
    }
}


