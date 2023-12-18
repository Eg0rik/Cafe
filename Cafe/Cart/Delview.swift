//
//  Delview.swift
//  Cafe
//
//  Created by MAC on 12/12/23.
//

import SwiftUI

struct Delview: View {
    @FetchRequest(fetchRequest: LocalDataRequest.shared.fetchRequest_coffeesInCatalog()) private var coffeeArray:FetchedResults<Coffee>
    
    var body: some View {
        List {
            
            if coffeeArray.isEmpty {
                
                Text("nothing")
            } else {
                
                ForEach(coffeeArray) { item in
                    
                    Button {
                        Provider.shared.delete(item, in: Provider.shared.newContext)
                    } label: {
                        Text(item.title)
                    }
                }
            }
        }
    }
    
}

#Preview {
    Delview()
}
