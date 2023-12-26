//
//  File.swift
//  Cafe
//
//  Created by MAC on 12/21/23.
//

import Foundation
import CoreData

class CoffeeCatalog: NSManagedObject, CoffeeProtocol {
    var type: CoffeeType = .catalog
    
    @NSManaged public var title: String
    @NSManaged public var price: String
}

class CartCoffee: CoffeeCatalog {
    @NSManaged var count: Double
}

class CoffeeHistory: CoffeeCatalog {
    
    @NSManaged public var count: NSDecimalNumber?
    @NSManaged public var order: Order?

    var unwrappedCount:String {
        count?.stringValue ?? "error"
    }
}

extension CartCoffee {
    
    static func GetCoffeeCart(withTitle title: String, in context: NSManagedObjectContext) -> CartCoffee? {
        let request = CartCoffee.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let coffees = try context.fetch(request)
            return coffees.first //always one coffee
        } catch {
            print("Error fetching entity: \(error)")
            return nil
        }
    }
}
