//
//  CartView.swift
//  Cafe
//
//  Created by MAC on 12/9/23.
//

import SwiftUI
import CoreData

struct CartView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var coffeesVM:CoffeesCartViewModel
    @State var showOrderView = false
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .topTrailing) {
                
                ScrollView(showsIndicators:false) {
                    HStack {
                        Text("PickUp")
                            .font(.system(size: 25))
                            .padding(6)
                            .customBorder(.brown)
                        
                        Spacer()
                        
                        //MARK: button 'delete all coffees in cart'
                        Button {
                            coffeesVM.clearAll()
                        } label: {
                            Text("clear cart")
                                .foregroundStyle(.white)
                                .font(.system(size: 25))
                                .padding(6)
                                .background(.brown)
                                .cornerRadius(10)
                        }
                        Spacer()
                        Spacer()
                        
                    }
                    .padding(.leading,15)
                    .frame(height: 50)
                    
                    if coffeesVM.coffeeArray.isEmpty {
                        Text("Add something in catalog to order")
                            .font(.system(size: 30))
                        
                    } else {
                        VStack {
                            ForEach(coffeesVM.coffeeArray) { item in
                                CartRowView(coffee: item)
                                    .padding(.horizontal)
                                Divider()
                                
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 100)
                }
                
                Button {
                    dismiss()
                } label: {
                    
                    ZStack {
                        Circle()
                            .fill(.gray.opacity(0.4))
                            .frame(width:40)
                        
                        Image(systemName: "multiply")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:20)
                            .bold()
                            .foregroundStyle(.black)
                        
                    }
                }
                .padding(.trailing,5)
            }

            HStack {
                
                Spacer()
                
                Text("\(coffeesVM.totalPriceCart.toString)")
                    .font(.system(size: 30))
                    .padding(.vertical,10)
                    .frame(maxWidth:.infinity)
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                
                Spacer()
                
                Button {
                    showOrderView = true
                } label: {
                    Text("Buy")
                        .font(.system(size: 30))
                        .padding(.vertical,10)
                        .frame(maxWidth:.infinity)
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                }
                .sheet(isPresented:$showOrderView) {
                    OrderView()
                }
                
                Spacer()
            }
            .padding(.horizontal,10)
            .padding(.bottom,1)
        }
        .padding(.top,5)
    }
    
}

struct CartRowView: View {
    
    @EnvironmentObject var coffeesVM:CoffeesCartViewModel
    var coffee:CartCoffee
    
    var priceStr:String {
        ((Double(coffee.price) ?? 0) * coffee.count).toString
    }
    
    init(coffee:CartCoffee) {
        self.coffee = coffee
    }
    
    var body: some View {
        
        VStack(spacing:0) {
            
            HStack() {
                
                Image(coffee.title)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:150,height: 200)
                
                Text(coffee.title)
                Spacer()
            }
            
            HStack {
                MyStepper(coffee: coffee, range: 1...20)
                    .padding(.leading,10)
                
                Spacer()
                
                Text("\(priceStr)$")
                    .font(.system(size: 30))
            }
        }
        .padding(6)
        //MARK: delete button
        .overlay(alignment: .topTrailing) {
            
            Button {
                delete()
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.red)
                    .frame(width:25)
            }
            .padding(10)
        }
    }
    
    func delete() {
        coffeesVM.delete(coffee)
    }
}


#Preview {
    CartView()
        .environment(\.managedObjectContext,Provider.shared.viewContext)
        .environmentObject(CoffeesCartViewModel())
        .onAppear {
            Provider.shared.loadData()
        }
}
