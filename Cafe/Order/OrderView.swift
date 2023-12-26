//
//  OrderView.swift
//  Cafe
//
//  Created by MAC on 12/21/23.
//

import SwiftUI
import CoreData

enum PayType: String, CaseIterable {
    case incash = "in cash"
    case bycard = "by card"
}

enum TimeType:CaseIterable {

    case min20
    case min25
    case min30
    case min40
    case min50

    var string:String {

        switch self {

            case .min20:
                "20 min"
            case .min25:
                "25 min"
            case .min30:
                "30 min"
            case .min40:
                "40 min"
            case .min50:
                "50 min"
        }
    }
}


struct OrderView: View {
    
    @EnvironmentObject var orderVM:OrderViewModel
    @EnvironmentObject var cartVM:CoffeesCartViewModel
    @Environment(\.managedObjectContext) var context:NSManagedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State var comment:String = ""
    @State var selectedPayment = PayType.incash
    @State var selectedTime = TimeType.min20
    
    var body: some View {
        
        NavigationView {
            
            
            List {
                
                Section("total") {
                    Text("\(cartVM.totalPriceCart.toString)$")
                }
                
                Section("How to pay?") {
                    Picker("", selection: $selectedPayment) {
                        
                        ForEach(PayType.allCases, id: \.self) { pay in
                            Text(pay.rawValue)
                                .tag(pay)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("When do you take it?") {
                    Picker("",selection: $selectedTime) {
                        ForEach(TimeType.allCases,id:\.self) { time in
                            Text(time.string)
                                .tag(time)
                        }
                    }
                    .pickerStyle(.palette)
                }
                
                
                Section("Comments") {
                    TextEditor(text: $comment)
                        .frame(height: 200) // Установка желаемой высоты текстового поля
                }
                
                Button {
                    addToHistory()
                    dismiss()
                } label: {
                    Text("Buy")
                }
                
            }
            .navigationTitle("Order")
        }
        .overlay(alignment: .topTrailing) {
            HStack(alignment: .top) {
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "multiply.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:40)
                        .bold()
                        .foregroundStyle(.black)
                }
            }
            .padding(.horizontal,15)
        }
    }
    
    //MARK: bad implementation(logic in view)
    func addToHistory() {
        let order = Order(context: Provider.shared.viewContext)
        let orderTime = Date.now
        order.orderTime = orderTime
        order.total = cartVM.totalPriceCart.toString
        order.comment = "pick up in " + selectedTime.string + "\n" + comment
        order.payment = selectedPayment.rawValue
        
        orderVM.addOrderToCoreData(order)
        
        let coffeesHistoryVM = CoffeesHitoryViewModel(order:order)
        coffeesHistoryVM.addCoffeesToOrder(array: cartVM.coffeeArray)
    }
}

#Preview {
    OrderView()
        .environment(\.managedObjectContext,Provider.shared.viewContext)
        .environmentObject(CoffeesCartViewModel())
        .environmentObject(OrderViewModel())
        .onAppear {
            Provider.shared.loadData()
        }
}
