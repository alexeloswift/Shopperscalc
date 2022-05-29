//
//  TabbarView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 5/23/22.
//

import SwiftUI

struct TabbarView: View {
    
    @Binding var selected : Int
    var numberSelected: Int
    var image: String

    var body: some View {
        Button(action: {
            self.selected = numberSelected
        }) {
            VStack {
                Image(systemName: image)
                    .foregroundColor(self.selected == numberSelected ? .blue : .gray)
            }
        }
    }
}

//struct TabbarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabbarView()
//    }
//}



struct FloatingTabbar : View {
    
    @Binding var selected : Int
    @State var expand = false
    
    @State var angle = 90.0
    
    var body : some View {
        
        HStack {
            
            Spacer(minLength: 0)
            
            HStack {
                
                if !self.expand {
                    
                    Button(action: {
                        self.expand.toggle()
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                            .padding()
                            .rotationEffect(
                                Angle.degrees(angle))
                    }
                } /// if end
                else {
                    
                    TabbarView(selected: $selected, numberSelected: 0, image: "person.crop.circle.fill")
                    
                    Spacer()
                    
                    TabbarView(selected: $selected, numberSelected: 1, image: "building.columns.fill")
                    
                    Spacer()
                    
                    TabbarView(selected: $selected, numberSelected: 2, image: "arrow.left.arrow.right")
                    
                    Spacer()
                    
                    TabbarView(selected: $selected, numberSelected: 3, image: "chart.line.uptrend.xyaxis")
                        .padding(.trailing)
                    
                    Spacer()
                    
                    Button(action: {
                        self.expand.toggle()
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                    }
                } /// else end
            } /// Inner HStack end
            .padding(.vertical,self.expand ? 10 : 8)
            .padding(.horizontal,self.expand ? 35 : 4)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 80))
            .padding(15)
            .shadow(color: .secondary, radius: 2, x: 2, y: 2)
            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.0))
        } /// Outer HStack end
    }
}
