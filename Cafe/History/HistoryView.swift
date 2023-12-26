//
//  HistoryVuew.swift
//  Cafe
//
//  Created by MAC on 12/21/23.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var vm:OrderViewModel
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView(showsIndicators:false) {
                
                VStack {
                    if vm.orderArray.isEmpty {
                        Text("buy something")
                    } else {
                        ForEach(vm.orderArray) { order in
                            
                            VStack(spacing:15) {
                                
                                HStack {
                                    
                                    Text(DateFormatter.localizedString(from: order.orderTime ?? Date.now, dateStyle: .medium, timeStyle: .short))
                                    
                                    Spacer()
                                    
                                    Text(order.payment ?? "error payment")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .padding(6)
                                        .background(.black)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                }
                                .padding(.horizontal,15)
                                
                                //MARK: CoffeeHistoryView
                                CoffeeHistoryView(order: order)
                                
                                HStack {
                                    VStack(alignment:.leading,spacing:5) {
                                        
                                        Text("Comments:")
                                        Text(order.comment ?? "error comment")
                                    }
                                    Spacer()
                                }
                                Divider()
                                
                                //MARK: Button delete
                                HStack {
                                    Button {
                                        vm.deleteOrder(order: order)
                                    } label: {
                                        Text("delete order")
                                    }
                                }
                            }
                            .padding(7)
                            .padding(.vertical,7)
                            .customBorder(.brown)
                            .padding()
                        }
                    }
                }
                
            }
            .navigationTitle("HistoryView")
        }
    }
    
}

struct CoffeeHistoryView: View {
    
    @ObservedObject var vm:CoffeesHitoryViewModel
    @State var coffeeTitle = ""
    
    init(order:Order) {
        self.vm = CoffeesHitoryViewModel(order: order)
    }
    
    var body: some View {
        
        VStack {
            Divider()
            ForEach(vm.coffeesArray.indices,id: \.self) { index in
                HStack {
                    Text("\(index+1) - ")
                    
                    Text("\(vm.coffeesArray[index].title) x \(vm.coffeesArray[index].unwrappedCount)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            Divider()
        }
    }
}

#Preview {
    HistoryView()
        .environment(\.managedObjectContext,Provider.shared.viewContext)
        .environmentObject(OrderViewModel())
        .onAppear {
            Provider.shared.loadData()
        }
}
