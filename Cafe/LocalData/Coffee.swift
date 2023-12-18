//
//  CoffeeModel+CoreDataProperties.swift
//  Cafe
//
//  Created by MAC on 12/12/23.
//
//

import Foundation
import CoreData


class Coffee: NSManagedObject,Identifiable {

    @NSManaged public var title: String
    @NSManaged public var price: String
    @NSManaged public var index: Int
    
    override func awakeFromInsert() { //при каждом первоначальном создании объекта
        super.awakeFromInsert()
        
//        setPrimitiveValue("0.0", forKey: "price")
//        setPrimitiveValue("", forKey: "title")
//        setPrimitiveValue(0, forKey: "index")
    }
}

class CoffeeCart:NSManagedObject,Identifiable {
    
    @NSManaged public var title: String
    @NSManaged public var price: String
    @NSManaged public var index: Int
    @NSManaged public var count: Int
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
//        setPrimitiveValue("0.0", forKey: "price")
//        setPrimitiveValue("", forKey: "title")
//        setPrimitiveValue(1, forKey: "count")
//        setPrimitiveValue(0, forKey: "index")
    }
}

class CoffeeHistory:CoffeeCart {
    
    @NSManaged public var description_:String
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
//        setPrimitiveValue("", forKey: "description_")
    }
}
