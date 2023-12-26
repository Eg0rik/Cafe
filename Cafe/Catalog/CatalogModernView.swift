//
//  CatalogModernView.swift
//  Cafe
//
//  Created by MAC on 12/6/23.
//

import SwiftUI
import CoreData

extension CGFloat {
    
    var int:Int {
        Int(self)
    }
}

struct CatalogModernView: View {
    
    //MARK: Gesture properties
    @State var offsetY:CGFloat = 0
    @State var currentIndex:CGFloat = 0
    
    @FetchRequest(fetchRequest: CoffeeCatalog.fetchRequest()) private var coffeeArray:FetchedResults<CoffeeCatalog>
    
    var body: some View {
        
            GeometryReader  {
                
                let size = $0.size
                
                let overCoffee = size.height/2.6
                
                LinearGradient(colors:
                                [
                                    .clear,
                                    .brown.opacity(0.2),
                                    .brown.opacity(0.6),
                                    .brown.opacity(0.9)
                                ]
                    .reversed()
                               , startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                
                LazyVStack(spacing:0) {
                    
                    ForEach(coffeeArray) { coffee in
                        
                        CoffeeView(coffee: coffee,size:size)
                            .frame(width: size.width,height: size.height*2/3)
                    }
                }
                .padding(.top,overCoffee)
                .offset(y:offsetY)
                .offset(y: -currentIndex * size.height*2/3)
                .onAppear {
                    currentIndex = CGFloat(coffeeArray.count - 1)
                }
                
                if coffeeArray.count > 1 {
                    HeaderView()
                }
            }
            .coordinateSpace(name: "SCROLL")
            .gesture(
                
                DragGesture()
                    .onChanged { value in
                        //slowig down the gesture
                        offsetY = value.translation.height*0.4
                    }
                    .onEnded { value in
                        
                        let translation = value.translation.height
                        
                        
                        withAnimation(.easeOut) {
                            
                            if translation < -150 { //lift element up
                                
                                if currentIndex < CGFloat(coffeeArray.count-1) {
                                    currentIndex += 1
                                }
                                
                            } else if translation > 150 { //move element down
                                
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                }
                            }
                            
                            offsetY = .zero
                        }
                    }
            )
        .preferredColorScheme(.light)
    }
    
    //MARK: will be crushed if we dell CoffeeCatalog items, because of index
    func HeaderView() -> some View {
        
        VStack {
            
            GeometryReader {
                
                let size = $0.size
                
                VStack {
                    
                    Text("\(coffeeArray[currentIndex.int].title)")
                        .font(.title.bold())
                        .multilineTextAlignment(.center)
                    
                    Text("\(coffeeArray[currentIndex.int].price)$")
                        .font(.title)
                        .opacity(0.5)
                    
                }
                .animation(.easeInOut, value: currentIndex)
                .frame(width: size.width-20)
                .padding(.horizontal,15)
            }
        }
        .padding(.top,10)
    }
}


struct CoffeeView:View {
    
    var coffee:CoffeeCatalog
    var size:CGSize
    
    @State var showAddToCardView = false
    
    private var cardSize:CGFloat {
        size.width
    }
    
    private var maxCardsDisplayWidth:CGFloat { // to show 3 cards
        size.width*5
    }
    
    var body: some View {
        
        GeometryReader { proxy in
            
            let offset = proxy.frame(in: .named("SCROLL")).minY - (size.height/2.6)
            
            let scale = offset <= 0 ? offset/maxCardsDisplayWidth : 0
            let reduceScale = 1 + scale
            let currentCardScale = offset/cardSize
            
            
            Image(coffee.title)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(reduceScale < 0 ? 0.001 : reduceScale,anchor: .init(x: 0.5, y: 1 - (currentCardScale/2.4)))
            
                //when its coming from bottom animate the scale from large to actual
                .scaleEffect(offset > 0 ? 1 + currentCardScale : 1,anchor: .top)
                .offset(y:offset > 0 ? currentCardScale * 200 : 0)
            
                //to compact cards
                .offset(y: currentCardScale * -140)
                .onTapGesture {
                    
                    if proxy.frame(in: .named("SCROLL")).minY < 330 && proxy.frame(in: .named("SCROLL")).minY > 270  {
                        showAddToCardView = true
                    }
                }
                .sheet(isPresented: $showAddToCardView, onDismiss: { showAddToCardView = false }, content: {
                    AddToCartView(coffee: coffee)
                })
        }
        .frame(width:size.width)
    }
}

#Preview {
    
    CatalogModernView() 
        .environment(\.managedObjectContext,Provider.shared.viewContext)
        .onAppear {
            Provider.shared.loadData()
        }
}
