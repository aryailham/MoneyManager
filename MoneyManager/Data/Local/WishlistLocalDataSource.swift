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
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishlistEntity")

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
}
