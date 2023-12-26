//
//  CoffeeCatalog+CoreDataProperties.swift
//  Cafe
//
//  Created by MAC on 12/20/23.
//
//

import Foundation
import CoreData


extension CoffeeCatalog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoffeeCatalog> {
        return NSFetchRequest<CoffeeCatalog>(entityName: "CoffeeCatalog")
    }

    @NSManaged public var index: Double
    @NSManaged public var price: String?
    @NSManaged public var title: String?

}

extension CoffeeCatalog : Identifiable {

}
