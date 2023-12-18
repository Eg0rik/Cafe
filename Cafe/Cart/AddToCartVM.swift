//
//  AddCoffeeToCardVM.swift
//  Cafe
//
//  Created by MAC on 12/9/23.
//

import Foundation
import CoreData

final class AddToCart {
    
    var coffee:CoffeeCart
    
    private let provider:Provider
    var context:NSManagedObjectContext
    
    init(coffee:Coffee) {
        
        self.provider = Provider.shared
        self.context = provider.newContext
        self.coffee = CoffeeCart(context: context)
        
        self.coffee.title = coffee.title
        self.coffee.count = 1
        self.coffee.index = coffee.index
        self.coffee.price = coffee.price
    }
    
    func save() {
        provider.persist(in: context)
    }
}
