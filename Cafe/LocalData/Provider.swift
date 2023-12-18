//
//  Provider.swift
//  Cafe
//
//  Created by MAC on 12/6/23.
//

import Foundation
import CoreData
import SwiftUI

final class Provider:ObservableObject { //its mean PersistentController
    
    static let shared = Provider() //
    
    private let persistentContainer:NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var newContext:NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    
    private init () {
        
        print("provider created")
        
        //where we take our local data
        persistentContainer = NSPersistentContainer(name: "LocalData") // name of coredata file
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true //every time a change occurs, we save it to a file
        persistentContainer.loadPersistentStores { _, error in //load coredata file
            
            if let error {
                fatalError("error in init() Provider, Unable to load store with error: \(error)")
            }
        }
    }
    
    func exists(_ CoffeeModel:Coffee,in context:NSManagedObjectContext) -> Coffee? {
        try? context.existingObject(with: CoffeeModel.objectID) as? Coffee
    }
    
    func exists(_ CoffeeModel:CoffeeCart,in context:NSManagedObjectContext) -> CoffeeCart? {
        try? context.existingObject(with: CoffeeModel.objectID) as? CoffeeCart
    }
    
    
    func delete(_ CoffeeModel:Coffee,in context:NSManagedObjectContext) {
        
        if let existingCoffeeHouse = exists(CoffeeModel, in: context) {
            
            context.delete(existingCoffeeHouse)
            
            Task(priority: .background) {
                
                do {
                    try await context.perform {
                        try context.save()
                    }
                }
                catch {
                    print("error in func delete() Provider: \(error)")
                }
            }
        }
    }
    
    func delete(_ CoffeeModel:CoffeeCart,in context:NSManagedObjectContext) {
        
        if let existingCoffeeHouse = exists(CoffeeModel, in: context) {
            
            context.delete(existingCoffeeHouse)
            
            Task(priority: .background) {
                
                do {
                    try await context.perform {
                        try context.save()
                    }
                }
                catch {
                    print("error in func delete() Provider: \(error)")
                }
            }
        }
    }
    
    
    func persist(in context:NSManagedObjectContext) {
        
        if context.hasChanges {
            
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("error in func persist() Provider unresolved error \(nserror), userInfo \(nserror.userInfo)")
            }
        }
    }
}


extension Provider {
    
    //save data to the CoreData file for the catalog only when the application is initially launched
    func loadData() {
        
        struct CoffeeForCheck {
            
            var title:String
            var price:String
            var index:Int
        }
        
        var coffeeArray = [CoffeeForCheck]()
        
        let prices:[String] = [
            "4.1","6.4","3.99","4.24","6.9","7.1","3.9","4.8","3.2","5.2"
        ]
        
        let titles:[String] = ["Flat White","Cappuccino","Pumpkin Cream Cold Brew","Starbucks® Cold Brew Coffee with Milk","Peppermint White Hot Chocolate",
                      "Cinnamon Caramel Cream Cold Brew","Pumpkin Spice Latte","Caffè Latte","Caramel Brulée Latte","Gingerbread Latte"
        ]
        
        for i in titles.indices {
            coffeeArray.append(CoffeeForCheck(title: titles[i], price: prices[i], index: i))
        }
        
        let request: NSFetchRequest<Coffee> = LocalDataRequest.shared.fetchRequest_coffeesInCatalog()
        
        do {
            
            let existingCoffeeCount = try viewContext.count(for: request)
            
            if existingCoffeeCount == 0 { // Если данных еще нет
                
                for coffee in coffeeArray {
                    
                    let context = newContext //you definitely need to get a new newContext
                    let newCoffee = Coffee(context: context)
                    newCoffee.title = coffee.title
                    newCoffee.price = coffee.price
                    newCoffee.index = coffee.index
                    
                    persist(in: context) // save to CoreData file
                }
                print("The data has been successfully saved in Core Data")
            } else {
                print("The data already exists in Core Data")
            }
        } catch {
            print("Error checking for data in Core Data: \(error)")
        }
    }
}
