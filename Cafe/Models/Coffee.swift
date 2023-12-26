//
//  CoffeeModel+CoreDataProperties.swift
//  Cafe
//
//  Created by MAC on 12/12/23.
//
//

import Foundation
import CoreData

enum CoffeeType {
    case catalog
    case history
    case cart
}

protocol CoffeeProtocol: NSManagedObject, Identifiable {
    
}


class CoffeeHistory:NSManagedObject, CoffeeProtocol {
    
    @NSManaged public var title: String
    @NSManaged public var price: String
    @NSManaged public var wasCreated: Double
    @NSManaged public var description_:String
    @NSManaged public var count: Double
    @NSManaged public var paymentType: String
    @NSManaged public var time: String
}




//class CoffeesFactory {
//
//    var context = Provider.shared.viewContext
//
//    static var shared = CoffeesFactory()
//    private init() { }
//
//    func createCoffee(type:CoffeeType) -> any CoffeeProtocol {
//
//        switch type {
//            case .catalog:
//                CoffeeCatalog(context:context)
//            case .history:
//                CoffeeCart(context:context)
//            case .cart:
//                CoffeeHistory(context:context)
//        }
//    }
//}
