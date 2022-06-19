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
                        .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
                        .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
                        .padding()
                    
                    DatePicker("", selection: $viewmodel.date)
                        .hidden()
                    
                    Button("Save") {
                        viewmodel.addListName(listName: viewmodel.listName)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .frame(width: 200, height: 60, alignment: .center)
                    .foregroundColor(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 17)
                            .stroke(Color.yellow, lineWidth: 3))
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

extension Color {
    static let lightShadow = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    static let darkShadow = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
    static let background = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
    static let neumorphictextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
}
