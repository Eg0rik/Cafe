//
//  AddToCardView.swift
//  Cafe
//
//  Created by MAC on 12/9/23.
//

import SwiftUI
import CoreData

struct AddToCartView: View {
    
    var coffee:CoffeeCatalog
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var coffeesCartVM:CoffeesCartViewModel //need viewModel to use func addCoffeeCart(...)
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors:
                    [
                     .brown.opacity(0.9),
                     .brown.opacity(0.3),
                     .brown.opacity(0.2),
                     .brown.opacity(0.5)
                    ]
                .reversed()
                           , startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack {
                
                HStack(alignment: .top) {
                    
                    VStack(alignment: .leading, spacing:15) {
                        
                        Text(coffee.title)
                            .font(.system(size: 25))
                            .bold()
                        
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(30)
                    
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
                .padding(.top,20)
                
                ZStack(alignment: .bottomLeading) {
                    
                    Image(coffee.title)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:300)
                        .padding(.top,20)
                    
                    Text("\(priceStr)$")
                        .font(.custom("AmericanTypewriter-Bold", size: 60))
                        .foregroundStyle(.white)
                        .offset(x:-15,y:15)
                        .shadow(radius: 10)
                }
                
                Spacer()
                
                HStack {
                    
                    Button {
                        addToCart()
                        dismiss()
                    } label: {
                        
                        Text("Add to cart")
                            .foregroundStyle(.black)
                            .font(.custom("American Typewriter",size: 29))
                            .padding(.horizontal)
                            .padding(.vertical,8)
                            .background(.brown.opacity(0.8))
                            .cornerRadius(10)
                    }
                }
                .padding(.leading,15)
                .padding(.bottom,25)
            }
        }
    }
}

extension AddToCartView {
    var priceStr:String {
        String(format:"%.2f",(Double(coffee.price)!))
    }
}

extension AddToCartView {
    func addToCart() {
        coffeesCartVM.addCoffeeCart(title: coffee.title, price: coffee.price)
    }
}
