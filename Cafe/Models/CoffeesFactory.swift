//
//  Factory.swift
//  Cafe
//
//  Created by MAC on 1/29/24.
//

import Foundation
import CoreData

enum CoffeeType {
    case catalog
    case cart
    case history
}

protocol CoffeeProtocol:CoreDataProtocol {
    var type:CoffeeType { get }
}

class CoffeesFactory {
    
    static let shared = CoffeesFactory()
    private init() { }
    
    func createCoffee(type:CoffeeType) -> any CoffeeProtocol {
        
        let viewContext = Provider.shared.viewContext
        
        switch type {
            case .catalog:
                return CoffeeCatalog(context: viewContext)
            case .cart:
                return CartCoffee(context: viewContext)
            case .history:
                return CoffeeHistory(context: viewContext)
        }
    }
}
