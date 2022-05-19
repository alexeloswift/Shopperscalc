//
//  ListVM.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/29/22.
//

import Foundation
import SwiftUI

class ListVM: ObservableObject, Identifiable {
    
    @Published var lists: [ListModel] = [
    ListModel(listName: "Nike", date: Date())
    ]
    
    @Published var listName: String = ""
    
    @Published var sortType: SortType = .alphabetical
    @Published var isPresented = false
    @Published var searched = ""
    @Published var date = Date()
    
    func addList(list: ListModel) {
        lists.append(list)
    }
    
    func removeList(at offsets: IndexSet) {
        lists.remove(atOffsets: offsets)
    }
    
    func sort(){
        
        switch sortType {
        case .alphabetical :
            lists.sort(by: { $0.listName < $1.listName })
        case .date :
            lists.sort(by: { $0.date > $1.date })
        }
    }
}

