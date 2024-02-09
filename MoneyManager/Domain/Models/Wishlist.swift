//
//  Wishlist.swift
//  MoneyManager
//
//  Created by Arya Ilham on 08/02/24.
//

import Foundation

struct Wishlist: Identifiable {
    let id: UUID
    let name: String
    let price: Int
    let dateAdded: Date
    
    init(id: UUID = UUID(), name: String, price: Int, dateAdded: Date) {
        self.id = id
        self.name = name
        self.price = price
        self.dateAdded = dateAdded
    }
}
