//
//  Provider.swift
//  Cafe
//
//  Created by MAC on 12/6/23.
//

import Foundation
import CoreData
import SwiftUI

final class Provider {
    
    static let shared = Provider()
    private let container:NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    var newContext:NSManagedObjectContext {
        container.newBackgroundContext()
    }
    
    private init () {
        
        //where we take our local data
        container = NSPersistentContainer(name: "LocalData") // name of coredata file
        container.viewContext.automaticallyMergesChangesFromParent = true //every time a change occurs, we save it to a file
        container.loadPersistentStores { _, error in //load coredata file
            if let error {
                fatalError("error in init() Provider, Unable to load store with error: \(error)")
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
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
        
        if UserDefaults.standard.bool(forKey: "firstLoad") {
            print("app already launched")
        }
        else {
            print("first launched")
            first_loadData()
            UserDefaults.standard.set(true,forKey: "firstLoad")
        }
        
//        remove(forKey: "firstLoad")
    }
    
    private func first_loadData() {
        
        if let coffees = loadData_from_JSONFile() {
            for item in coffees {
                let context = newContext //you definitely need to get a new newContext
                let newCoffee = CoffeeCatalog(context: context)
                newCoffee.title = item.title
                newCoffee.price = item.price
                
                persist(in: context) // save to CoreData file
            }
        }
        
        struct CoffeeJSON: Codable {
            var title: String
            var price: String
        }
        
        //initial data in json file
        func loadData_from_JSONFile() -> [CoffeeJSON]? {
            if let path = Bundle.main.path(forResource: "CoffeeCatalogArray", ofType: "json") {
                do {
                    let url = URL(fileURLWithPath: path)
                    let data = try Data(contentsOf: url)
                    
                    let decodedData = try JSONDecoder().decode([CoffeeJSON].self, from: data)
                    
                    return decodedData
                } catch {
                    print("Error in reading file: \(error)")
                }
            } else {
                print("File didn't find")
            }
            
            return nil
        }
    }
    
    private func remove(forKey:String) {
        UserDefaults.standard.removeObject(forKey: forKey)
    }
}
