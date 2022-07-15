//
//  HistoryView.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/22/22.
//

import SwiftUI

struct HistoryView: View {
    
    @State private var animationState: AnimationState = .normal
    @State var isPresented = false
    
    @EnvironmentObject var persistenceController: PersistenceController
    @StateObject var viewmodel: CalculatorVM
    
    
    init(persistenceController: PersistenceController) {
        let viewmodel = CalculatorVM(persistenceController: persistenceController)
        _viewmodel = StateObject(wrappedValue: viewmodel)
    }
    
    var body: some View {
        if viewmodel.calculation.isEmpty {
            ZStack {
                Color.gray
                    .ignoresSafeArea()
                VStack {
                    Image("error")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(calculate())
                    Text("There are no calculations to display yet.")
                    Text("🙃")
                        .font(.title)
                    
                    Text("Once you make a calculation, it will be displayed here.")
                    Spacer()
                    
                }
                .multilineTextAlignment(.center)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring()) {
                        animationState = .expand
                        DispatchQueue.main.asyncAfter (deadline: .now() + 0.5) {
                            withAnimation(.spring()) {
                                animationState = .compress
                                DispatchQueue.main.asyncAfter (deadline: .now() + 0.3) {
                                    withAnimation(.spring()) {
                                        animationState = .normal
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            NavigationView {
                
                List {
                    ForEach(viewmodel.calculation, id: \.fullPrice) {
                        CalculationRow(calculation: $0)
                    }
                    .onDelete { index in
                        viewmodel.deleteCalculation(at: index)
                    }
                    .listRowSeparator(.hidden)
                    .padding(10)
                    .cornerRadius(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10 , style: .continuous)
                            .stroke(.yellow, lineWidth: 0.7)
                            .shadow(color: .yellow, radius: 0.7))
                }
                .navigationBarTitle(Text("History"))
                .toolbar {
                    EditButton()
                        .modifier(AccentIcons())
                }
                .navigationBarItems(trailing: Button(action: {
                    isPresented = true
                }) {
                    Image(systemName: "trash")
                }
                    .modifier(AccentIcons())
                    .alert("Delete All?", isPresented: $isPresented) {
                        Button("Yes", role: .destructive)  {
                            viewmodel.deleteAllCalculations()
                        }
                    }
                )
            }
        }
    }
    
    func calculate() -> Double {
        switch animationState{
            case .normal:
                return 0.35
            case .compress:
                return 0.18
            case .expand:
                return 0.8
        }
    }
}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(persistenceController: .preview)
        
    }
}
