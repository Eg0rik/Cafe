//
//  CoffeeProtocol.swift
//  Cafe
//
//  Created by MAC on 1/24/24.
//

import Foundation
import CoreData

protocol CoreDataProtocol: Identifiable { }

extension CoreDataProtocol where Self: NSManagedObject {
    
    static var entityName:String {
        String(describing: Self.self)
    }
    
    static func fetchRequest() -> NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: Self.entityName)
        request.sortDescriptors = []
        return request
    }
    
    static func exists(_ object:Self,in context:NSManagedObjectContext) -> Self? {
        try? context.existingObject(with: object.objectID) as? Self
    }
    
    static func delete(_ object:Self,in context:NSManagedObjectContext) {
        if exists(object, in: context) != nil {
            context.delete(object)
            Provider.shared.persist(in: context)
        }
    }
}
