//
//  CoffeeCartModel.swift
//  Cafe
//
//  Created by MAC on 12/21/23.
//

import Foundation
import CoreData

class CoffeeCart:NSManagedObject, CoffeeProtocol {
    
    @NSManaged public var title: String
    @NSManaged public var price: String
    @NSManaged public var count: Double
}

extension CoffeeCart {
    
    static func fetchRequest() -> NSFetchRequest<CoffeeCart> {
        
        let request = NSFetchRequest<CoffeeCart>(entityName: "CoffeeCart")
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CoffeeCart.title,ascending: true)]
        
        return request
    }
    
    static func exists(_ CoffeeModel:CoffeeCart,in context:NSManagedObjectContext) -> CoffeeCart? {
        try? context.existingObject(with: CoffeeModel.objectID) as? CoffeeCart
    }
    
    static func delete(_ CoffeeModel:CoffeeCart,in context:NSManagedObjectContext) {
        
        if let existingCoffeeHouse = exists(CoffeeModel, in: context) {
            
            context.delete(existingCoffeeHouse)
            
            Task(priority: .background) {
                
                do {
                    try await context.perform {
                        try context.save()
                    }
                }
                catch {
                    print("error in CoffeeCart func delete() : \(error)")
                }
            }
        }
    }
}
