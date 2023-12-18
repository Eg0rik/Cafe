//
//  CafeApp.swift
//  Cafe
//
//  Created by MAC on 12/6/23.
//

import SwiftUI

@main
struct CafeApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            
            MainView()
                .environment(\.managedObjectContext,Provider.shared.viewContext) //внедряем наш viewContext
                .onAppear {
                    Provider.shared.loadData()
                }
        }
    }
}
