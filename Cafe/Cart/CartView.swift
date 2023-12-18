//
//  CartView.swift
//  Cafe
//
//  Created by MAC on 12/9/23.
//

import SwiftUI

struct CartView: View {
    
   @FetchRequest(fetchRequest: LocalDataRequest.shared.fetchRequest_coffeesInCart()) private var coffeeArray:FetchedResults<CoffeeCart>
    
    var provider = Provider.shared
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                if coffeeArray.isEmpty {
                    
                    Text("Add something in catalog to order")
                        .font(.system(size: 30))
                    
                } else {
                    
                    ForEach(coffeeArray) { item in
                        
                        CartRowView(coffee: item)
                            .swipeActions(allowsFullSwipe: true) {
                                
                                Button(role: .cancel) {
                                    //editCoffeeHouse = item
                                } label: {
                                    Label("Edit",systemImage: "pencil")
                                }
                                .tint(.orange)
                                
                                Button(role: .destructive) {
//                                    provider.delete(item, in: provider.newContext) //для безопасного редактирирования/удаления newContext instead of viewContext
                                } label: {
                                    Label("delete",systemImage: "trash")
                                }
                                .tint(.red)
                                
                            }
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Cart")
        }
        
    }
    
//    @ViewBuilder
    func HeaderView() -> some View {
        
//        VStack {
//            
//            GeometryReader {
//                
//                let size = $0.size
//                
//                VStack {
//                    
//                    Text("\(coffeeArray[currentIndex.int].title)")
//                        .font(.title.bold())
//                        .multilineTextAlignment(.center)
//                    
//                    Text("\(coffeeArray[currentIndex.int].price)$")
//                        .font(.title)
//                        .opacity(0.5)
//                    
//                }
//                .animation(.easeInOut, value: currentIndex)
//                .frame(width: size.width-20)
//                .padding(.horizontal,15)
//            }
//        }
//        .padding(.top,10)
        VStack {
            
        }
    }
}


#Preview {
    CartView()
        .environment(\.managedObjectContext,Provider.shared.viewContext)
        .onAppear {
            Provider.shared.loadData()
        }
}

struct CartRowView: View {
    
    var coffee:CoffeeCart
    
    var provider = Provider.shared
    
    var priceStr:String {
        String(format:"%.2f",(Double(coffee.price)! * Double(coffee.count)))
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
            .overlay(alignment: .topTrailing) {
                Button {
                    provider.delete(coffee, in: provider.newContext) //для безопасного редактирирования/удаления newContext instead of viewContext
                } label: {
                    Image(systemName: "trash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.red)
                        .frame(width:25)
                }
                .padding(10)
                
            }
            
            HStack {
                
                Spacer()
                
//                MyStepper(coffee:coffee, range: 1...20)
                
                Spacer()
                
                Text(priceStr)
            }
        }
        .border(.black)
    }
}
