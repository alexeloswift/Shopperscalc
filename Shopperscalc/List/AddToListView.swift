//
//  AddToListView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/29/22.
//

import SwiftUI

struct AddToListView: View {
    var body: some View {
        
        List {
            Text("dskn;")
            Text("dskn;")

            Text("dskn;")
            Text("dskn;")
            Text("dskn;")
            Text("dskn;")

        }
        

        .navigationTitle("Add calculation to list")
        .toolbar {
            Button("Create List") {

            }
        }
//        .navigationBarItems(trailing: Button(action: {
//
//        }) {
//            Image(systemName: "trash")
//        })

    }
}

struct AddToListView_Previews: PreviewProvider {
    static var previews: some View {
        AddToListView()
    }
}
