//
//  Wishlist.swift
//  MoneyManager
//
//  Created by Arya Ilham on 08/02/24.
//

import Foundation

struct Wishlist: Identifiable {
    let id: String
    let name: String
    let price: Int
    let dateAdded: Date
    
    init(name: String, price: Int, dateAdded: Date) {
        id = UUID().uuidString
        self.name = name
        self.price = price
        self.dateAdded = dateAdded
    }
}
