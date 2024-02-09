//
//  WishlistLocalDataSource.swift
//  MoneyManager
//
//  Created by Arya Ilham on 08/02/24.
//

import Foundation
import CoreData

protocol WishlistLocalDataSource {
    func saveNewWishlist(_ newData: Wishlist)
    func getWishlist() -> [Wishlist]
    func delete(id: UUID, completion: @escaping ((Bool) -> Void))
}

class WishlistCoreDataLocalDataSource: WishlistLocalDataSource {
    private let manager = CoreDataManager.shared
    
    func saveNewWishlist(_ newData: Wishlist) {
        let context = manager.persistentContainer.viewContext
        
        let wish = WishlistEntity(context: context)
        wish.name = newData.name
        wish.id = UUID()
        wish.dateAdded = Date()
        wish.price = Int32(newData.price)
        do {
            try manager.saveContext()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getWishlist() -> [Wishlist] {
        let context = manager.persistentContainer.viewContext

        var wishlist: [Wishlist] = []

        do {
            let items = try context.fetch(WishlistEntity.fetchRequest())
            wishlist = items.map({ entity in
                Wishlist(id: entity.id ?? UUID(),
                         name: entity.name ?? "",
                         price: Int(entity.price),
                         dateAdded: entity.dateAdded ?? Date())
            })
        } catch {
            fatalError(error.localizedDescription)
        }
        
        return wishlist
    }
    
    func delete(id: UUID, completion: @escaping ((Bool) -> Void)) {
        let context = manager.persistentContainer.viewContext

        let fetch: NSFetchRequest<WishlistEntity> = WishlistEntity.fetchRequest()
        fetch.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let result = try context.fetch(fetch)
            if let item = result.first {
                context.delete(item)
                try manager.saveContext()
                completion(true)
            }
        } catch {
            print("Error when delete wishlist: \(error.localizedDescription)")
            completion(false)
        }
    }
}
