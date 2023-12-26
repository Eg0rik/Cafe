//
//  Order+CoreDataClass.swift
//  Cafe
//
//  Created by MAC on 1/9/24.
//
//

import Foundation
import CoreData


class Order: NSManagedObject,CoreDataProtocol {
    
    @NSManaged public var total: String?
    @NSManaged public var comment: String?
    @NSManaged public var payment: String?
    @NSManaged public var orderTime: Date?
    @NSManaged public var coffeesHitory: NSSet?
    
    var coffeesArray: [CoffeeHistory] {
        let coffeesSet = coffeesHitory as? Set<CoffeeHistory> ?? []
        
        return coffeesSet.sorted {
            $0.unwrappedCount < $1.unwrappedCount
        }
    }
}

// MARK: Generated accessors for coffeesHitory
extension Order {

    @objc(addCoffeesHitoryObject:)
    @NSManaged func addToCoffeesHitory(_ value: CoffeeHistory)

    @objc(removeCoffeesHitoryObject:)
    @NSManaged func removeFromCoffeesHitory(_ value: CoffeeHistory)

    @objc(addCoffeesHitory:)
    @NSManaged func addToCoffeesHitory(_ values: NSSet)

    @objc(removeCoffeesHitory:)
    @NSManaged func removeFromCoffeesHitory(_ values: NSSet)
}
