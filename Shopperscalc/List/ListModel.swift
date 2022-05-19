//
//  ListModel.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/29/22.
//

import Foundation

struct ListModel: Equatable {
    
    let listName: String
    let date: Date
    
}

enum SortType : String , Identifiable , CaseIterable {
    
    var id : String { rawValue }
    
    case alphabetical
    case date
    
}
