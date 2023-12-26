//
//  CoffeeCartViewModel.swift
//  Cafe
//
//  Created by MAC on 1/17/24.
//

import Foundation
import CoreData
import SwiftUI


class CoffeesCartViewModel:ObservableObject {
    
    var viewContext = Provider.shared.viewContext
    @Published var coffeeArray:[CartCoffee] = []
    @Published var totalPriceCart:Double = 0 {
        didSet {
            saveTotalPrice()
        }
    }
    
    init() {
        fetchCoffees()
        loadTotalPrice()
    }
    
    func update() {
        fetchCoffees()
        calculatingTotal()
        save(in: viewContext)
    }
    
    func updateWithoutFetch() {
        calculatingTotal()
        save(in: viewContext)
    }
    
    private func fetchCoffees() {
        let request = CartCoffee.fetchRequest()
        
        do {
            coffeeArray = try viewContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func addCoffeeCart(title:String,price:String) {
        if let coffee = CartCoffee.GetCoffeeCart(withTitle: title, in: viewContext) {
            coffee.count += 1
        } else {
            let coffeeCart = CartCoffee(context: viewContext)
            coffeeCart.title = title
            coffeeCart.price = price
            coffeeCart.count = 1
        }
        update()
    }
    
    func delete(_ coffee:CartCoffee) {
        CartCoffee.delete(coffee, in: viewContext)
        update()
    }
    
    private func save(in context:NSManagedObjectContext) {
        Provider.shared.persist(in:context)
    }
    
    func clearAll() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CartCoffee")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try viewContext.execute(deleteRequest)
            Provider.shared.persist(in: viewContext)
        } catch {
            print("Failed to delete all CoffeeCarts: \(error)")
        }
        update()
    }
    
    private func calculatingTotal() {
        var sum = 0.0
        for item in coffeeArray {
            sum += item.count * (Double(item.price) ?? -1)
        }
        totalPriceCart = sum
        saveTotalPrice()
    }
    
    private func saveTotalPrice() {
        UserDefaults.standard.setValue(totalPriceCart, forKey: "totalPriceCart")
    }
    
    private func loadTotalPrice() {
        totalPriceCart = UserDefaults.standard.double(forKey: "totalPriceCart")
    }
}
