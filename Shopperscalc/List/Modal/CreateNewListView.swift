//
//  CreateNewListView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 5/16/22.
//

import SwiftUI

struct CreateNewListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var viewmodel = ListVM()
    
//    @FetchRequest(
//        entity: Lists.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \Lists.listTitle, ascending: true)
//        ])
//
//    var listName: FetchedResults<Lists>
    
    @FetchRequest(sortDescriptors: []) private var listName: FetchedResults<ListName>

    
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
                        addListName(listName: viewmodel.listName)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(Color.black)
                    .background(
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 275, height: 60, alignment: .center)
                        .foregroundColor(.yellow)
                        .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
                        .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
                        
                    )
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
                            addListName(listName: viewmodel.listName)
                            presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            

            
        }
    }
    
    func addListName(listName: String) {
        let newListName = ListName(context: managedObjectContext)
        
        newListName.listTitle = listName
        saveContext()
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}

struct CreateNewListView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewListView()
    }
}

extension Color {
    static let lightShadow = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    static let darkShadow = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
    static let background = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
    static let neumorphictextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
}
