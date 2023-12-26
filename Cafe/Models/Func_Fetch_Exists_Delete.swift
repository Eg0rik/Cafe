//
//  Func_Fetch_Exists_Delete.swift
//  Cafe
//
//  Created by MAC on 1/18/24.
//

import CoreData

//extension NSManagedObject {
//    
//    static func fetchRequest<T: NSManagedObject>() -> NSFetchRequest<T> {
//        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \T.objectID, ascending: true)]
//        return request
//    }
//
//    static func exists<T: NSManagedObject>(_ object: T, in context: NSManagedObjectContext) -> T? {
//        try? context.existingObject(with: object.objectID) as? T
//    }
//
//    static func delete<T: NSManagedObject>(_ object: T, in context: NSManagedObjectContext) async {
//        
//        if let existingObject = exists(object, in: context) {
//            context.delete(existingObject)
//            do {
//                try await context.perform {
//                    try context.save()
//                }
//            } catch {
//                print("Error in \(T.self) delete: \(error)")
//            }
//        }
//    }
//}
