//
//  LocalData.swift
//  Cafe
//
//  Created by MAC on 12/12/23.
//

import Foundation
import CoreData

final class LocalDataRequest {
    
    static let shared = LocalDataRequest()
    
    private init() {}
    
    func fetchRequest_coffeesInCart() -> NSFetchRequest<CoffeeCart> {
        
        let request = NSFetchRequest<CoffeeCart>(entityName: "CoffeesInCart")
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CoffeeCart.title,ascending: true)]
        
        return request
    }
    
    func fetchRequest_coffeesInHistory() -> NSFetchRequest<CoffeeHistory> {
        let request = NSFetchRequest<CoffeeHistory>(entityName: "CoffeesInHistory")
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CoffeeHistory.title,ascending: true)]
        
        return request
    }
    
    func fetchRequest_coffeesInCatalog() -> NSFetchRequest<Coffee> {
        let request = NSFetchRequest<Coffee>(entityName: "CoffeesInCatalog")
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Coffee.price,ascending: true)]
        
        return request
    }
}
