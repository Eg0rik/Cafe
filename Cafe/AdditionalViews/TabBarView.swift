//
//  TabBarView.swift
//  Cafe
//
//  Created by MAC on 12/9/23.
//

import SwiftUI

enum TabBarItem:String {
    
    case menuView = "book.pages"
    case mapView = "map.fill"
    case cartView = "cart.fill"
    case historyView = "clock.fill"
    
    var name:String {
        switch self {
            case .menuView:
                "Menu"
            case .mapView:
                "Map"
            case .cartView:
                "Cart"
            case .historyView:
                "History"
        }
    }
}

struct TabBarView: View {
    
    @Binding var tabSelected:TabBarItem
    
    var tabBarItems:[TabBarItem] = [.menuView,.mapView,.cartView,.historyView]
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.white)
            
            HStack(spacing:50) {
                
                ForEach(tabBarItems,id: \.self) { item in
                    
                    Button {
                        
                        withAnimation(.easeOut) {
                            tabSelected = item
                        }
                        
                    } label: {
                        
                        VStack {
                            
                            Image(systemName: item.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:25,height: 25)
                                .foregroundStyle(tabSelected == item ? .black : .gray)
                            
                            Text(item.name)
                                .foregroundStyle(tabSelected == item ? .black : .gray)
                                .font(tabSelected == item ? .callout.bold() : .callout)
                        }
                    }
                    .padding(.vertical,15)
                }
            }
        }
        .frame(height: 70)
        .padding(.horizontal)
    }
}

#Preview {
    
    VStack {
        Spacer()
        
        TabBarView(tabSelected: .constant(TabBarItem.menuView))
    }
}
