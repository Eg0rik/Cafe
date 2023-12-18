//
//  MainView.swift
//  Cafe
//
//  Created by MAC on 12/9/23.
//

import SwiftUI

struct MainView: View {
    
    @State var tabSelected = TabBarItem.menuView
    
    var body: some View {
        
        TabView(selection: $tabSelected) {
            
            CatalogModernView()
                .tag(TabBarItem.menuView)
            
            MapView()
                .tag(TabBarItem.mapView)
            
            CartView()
                .tag(TabBarItem.cartView)
        }
        .overlay(alignment: .bottom) {
            TabBarView(tabSelected: $tabSelected)
        }
    }
}

#Preview {
    MainView()
        .environment(\.managedObjectContext,Provider.shared.viewContext)
        .onAppear {
            Provider.shared.loadData()
        }
}
