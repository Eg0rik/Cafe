//
//  AddToCardView.swift
//  Cafe
//
//  Created by MAC on 12/9/23.
//

import SwiftUI
import CoreData

struct AddToCartView: View {

    var provider = Provider.shared
    
    @Environment(\.dismiss) var dismiss
    
    var coffee:Coffee
    
    @State var count = 1
    
    var priceStr:String {
        String(format:"%.2f",(Double(coffee.price)! * Double(count)))
    }
    
    var body: some View {
        
        
        ZStack {
            
            LinearGradient(colors:
                    [
                     .brown.opacity(0.9),
                     .brown.opacity(0.6),
                     .brown.opacity(0.2),
                     .clear
                    ]
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
                    
                    MyStepper(count: $count,range: 1...20)
                    
                    Spacer()
                    
                    Button {
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
                    
                    Spacer()
                }
                .padding(.leading,15)
                .padding(.bottom,25)
            }
        }
    }
}


struct MyStepper:View {
    
    @Binding var count:Int
    var range:ClosedRange<Int>
    
    var body: some View {
        
        HStack {
            
            Button {
                
                if count > range.lowerBound {
                    count -= 1
                }
            } label: {
                Image(systemName: "minus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:20,height: 20)
                    .foregroundStyle(count > range.lowerBound ? .black : .gray)
            }
            .padding()
            .background(.gray.opacity(0.2))
            .cornerRadius(10)
            
            Text(String(count))
                .font(.system(size: 25))
                .frame(width:45)
            
            Button {
                
                if count < range.upperBound {
                    count += 1
                }
                
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:20,height:20)
                    .foregroundStyle(count < range.upperBound ? .black : .gray)
            }
            .padding()
            .background(.gray.opacity(0.2))
            .cornerRadius(10)
        }
    }
}
