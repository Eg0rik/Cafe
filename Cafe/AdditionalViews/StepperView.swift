//
//  StepperView.swift
//  Cafe
//
//  Created by MAC on 12/21/23.
//

import Foundation
import SwiftUI

struct MyStepper:View {
    
    @EnvironmentObject var coffeesVM:CoffeesCartViewModel
    @StateObject var coffee:CartCoffee
    var range:ClosedRange<Double>
    
    var body: some View {
        
        HStack {
            
            Button {
                
                if coffee.count == 1 {
                    deleteItem()
                }
                
                if coffee.count > range.lowerBound {
                    coffee.count -= 1
                    update()
                }
            } label: {
                Image(systemName: "minus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:20,height: 20)
                    .foregroundStyle(.black)
            }
            .padding()
            .background(.gray.opacity(0.2))
            .cornerRadius(10)
            
            Text(String(Int(coffee.count)))
                .font(.system(size: 25))
                .frame(width:45)
            
            Button {
                
                if coffee.count < range.upperBound {
                    coffee.count += 1
                    update()
                }
                
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:20,height:20)
                    .foregroundStyle(coffee.count < range.upperBound ? .black : .gray)
            }
            .padding()
            .background(.gray.opacity(0.2))
            .cornerRadius(10)
        }
    }
}

extension MyStepper {
    
    func update() {
        coffeesVM.updateWithoutFetch()
    }
    
    func deleteItem() {
        coffeesVM.delete(coffee)
    }
}
