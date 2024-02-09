//
//  WishlistRepository.swift
//  MoneyManager
//
//  Created by Arya Ilham on 08/02/24.
//

import Foundation

protocol WishlistRepository {
    func saveNewWishlist(_ newData: Wishlist)
    func getWishlist() -> [Wishlist]
    func delete(id: UUID, completion: @escaping ((Bool) -> Void))
}

class WishlistDefaultRepository: WishlistRepository {
    private let local: WishlistLocalDataSource
    
    init(local: WishlistLocalDataSource = WishlistCoreDataLocalDataSource()) {
        self.local = local
    }
    
    func saveNewWishlist(_ newData: Wishlist) {
        local.saveNewWishlist(newData)
    }
    
    func getWishlist() -> [Wishlist] {
        local.getWishlist()
    }
    
    func delete(id: UUID, completion: @escaping ((Bool) -> Void)) {
        local.delete(id: id, completion: completion)
    }
}
