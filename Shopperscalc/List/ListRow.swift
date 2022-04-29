//
//  ListRow.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/29/22.
//

import SwiftUI

struct ListRow: View {
    
    var list: ListModel
    
    var body: some View {
        
        VStack (alignment : .leading){
                    HStack{
                        VStack(alignment:.leading) {
//                            Text("Name:")
//                                .font(.caption)
//                                .foregroundColor(.secondary)
                            Text(list.listName)
                                .font(.system(size: 20, weight: .bold))
                        }
                        Spacer()
                        VStack (alignment:.leading){
                            Text("Date:")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(list.date , style: .date)
                        }
                    }
//                    Text("Task:")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                    Text(task.taskName)
//                        .font(.system(size: 15, weight: .bold))
//                        .italic()
                }
                .padding(10)
                .cornerRadius(10)
                .background(
                    RoundedRectangle(cornerRadius: 10 , style: .continuous)
                        .stroke(.yellow, lineWidth: 0.7)
                .shadow(color: .yellow, radius: 0.7))
            }
        }
                    


struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(list: ListModel.init(listName: "Nike", date: Date()))
    }
}
