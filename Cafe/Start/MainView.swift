//
//  MainView.swift
//  Cafe
//
//  Created by MAC on 12/9/23.
//

import SwiftUI

struct MainView: View {
    
    @State var tabSelected = TabBarItem.menuView
    @State var isCartSheetPresented = false
    
    @StateObject var coffeesCartViewModel = CoffeesCartViewModel()
    @StateObject var orderViewModel = OrderViewModel()
    
    var body: some View {
        
        TabView(selection: $tabSelected) {
            
            CatalogModernView()
                .tag(TabBarItem.menuView)
                .environmentObject(coffeesCartViewModel)
//
//            MapView()
//                .tag(TabBarItem.mapView)
            
            HistoryView()
                .tag(TabBarItem.historyView)
                .environmentObject(orderViewModel)
        }
        .overlay(alignment: .bottom) {
            TabBarView(tabSelected: $tabSelected)
        }
        .onChange(of: tabSelected) { oldValue, newValue in
            
            if newValue == .cartView {
                isCartSheetPresented = true
                tabSelected = oldValue
            }
        }
        .sheet(isPresented: $isCartSheetPresented) {
            CartView()
                .environmentObject(coffeesCartViewModel)
                .environmentObject(orderViewModel)
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
