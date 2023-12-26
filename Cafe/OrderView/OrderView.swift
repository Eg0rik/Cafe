//
//  OrderView.swift
//  Cafe
//
//  Created by MAC on 12/21/23.
//

import SwiftUI

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

enum PayType: String, CaseIterable {
    case incash = "in cash"
    case bycard = "by card"
}

struct OrderView: View {
    
    @State var name:String = ""
    @State var selectedTime:TimeType = .min20
    @State var text:String = ""
    @State var selectedPay = PayType.incash
    @State var number:String = ""
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                    
                Section("Name") {
                    TextField("write", text: $name)
                }
                
                Section("Number") {
                    TextField("write", text: $number)
                }
                  
                Section("When will you take it?") {
                    
                    Picker("", selection: $selectedTime) {
                        
                        ForEach(TimeType.allCases, id: \.self) { time in
                            Text(time.string)
                                .tag(time)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("How to pay?") {
                    Picker("", selection: $selectedPay) {
                        
                        ForEach(PayType.allCases, id: \.self) { pay in
                            Text(pay.rawValue)
                                .tag(pay)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                
                Section("Comments") {
                    TextEditor(text: $text)
                        .frame(height: 200) // Установка желаемой высоты текстового поля
                }
                
            }
            .navigationTitle("Order")
            
        }
    }
    
}

#Preview {
    OrderView()
}


extension OrderView {
    
    func addToHistory() {
        
        let newContext = provider.newContext
        
        let newCoffee = CoffeeCart(context: newContext)
        
        newCoffee.title = coffee.title
        newCoffee.count = 1
        newCoffee.price = coffee.price
        
        provider.persist(in: newContext)
        
    }
}
