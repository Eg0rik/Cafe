//
//  CoffeesHistoryViewModel.swift
//  Cafe
//
//  Created by MAC on 1/9/24.
//

import Foundation
import CoreData

class CoffeesHitoryViewModel: ObservableObject {
    
    private let provider = Provider.shared
    private let viewContext = Provider.shared.viewContext
    @Published var coffeesArray = [CoffeeHistory]()
    
    var order:Order
    
    init(order:Order) {
        self.order = order
        fetchCoffees()
    }
    
    func fetchCoffees() {
        coffeesArray = order.coffeesArray
    }
    
    func addCoffeeToCoreData(title:String,price:String,count:Decimal) {
        let coffee = CoffeeHistory(context: viewContext)
        coffee.count = count as NSDecimalNumber
        coffee.title = title
        coffee.price = price
        
        order.addToCoffeesHitory(coffee)
        save()
        fetchCoffees()
    }
    
    func save() {
        provider.persist(in: viewContext)
    }
    
    //MARK: transform and add [CartCoffee] to [CoffeeHistory]
    func addCoffeesToOrder(array:[CartCoffee]) {
        for item in array {
            addCoffeeToCoreData(title: item.title, price: item.price, count: Decimal(item.count))
        }
    }
}
