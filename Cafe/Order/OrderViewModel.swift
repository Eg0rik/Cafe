//
//  OrderViewModel.swift
//  Cafe
//
//  Created by MAC on 1/9/24.
//

import Foundation
import CoreData

class OrderViewModel: ObservableObject {
    
    private let provider = Provider.shared
    private let viewContext = Provider.shared.viewContext
    @Published var orderArray = [Order]()
    
    init() {
        fetchOrderData()
    }
    
    func update() {
        provider.persist(in: viewContext)
        fetchOrderData()
    }
    
    func fetchOrderData() {
        let request = Order.fetchRequest()
        
        do {
            orderArray = try viewContext.fetch(request)
        } catch {
           fatalError("error in OrderViewModel func fetchOrderData: \(error)")
        }
    }
    
    func addOrderToCoreData(total:String,comment:String,payment:String,orderTime:Date) {
        let order = Order(context: viewContext)
        order.total = total
        order.comment = comment
        order.payment = payment
        order.orderTime = orderTime
        
        update()
    }
    
    func addOrderToCoreData(_ order:Order) { //just need to save and fetch, order was created
        update()
    }
    
    private func clearCoffeesArrayInOrder(order:Order) {
        for item in order.coffeesArray {
            CoffeeHistory.delete(item, in: viewContext)
        }
        update()
    }
    
    func deleteOrder(order:Order) {
        clearCoffeesArrayInOrder(order: order)
        Order.delete(order, in: viewContext)
        update()
    }
}

