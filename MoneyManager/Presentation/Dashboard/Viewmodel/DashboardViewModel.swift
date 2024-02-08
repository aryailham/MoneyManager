//
//  DashboardViewModel.swift
//  MoneyManager
//
//  Created by Arya Ilham on 08/02/24.
//

import Foundation

protocol DashboardViewModelInput {
    
}

protocol DashboardViewModelOutput {
    var wishlist: [Wishlist] { get }
}

typealias DashboardViewModel = DashboardViewModelInput & DashboardViewModelOutput

class DashboardDefaultViewModel: DashboardViewModel {

    @Published var wishlist: [Wishlist] = []
    
    init() {
        getCurrentWishlist()
    }
    
    func getCurrentWishlist() {
        wishlist = [
            Wishlist(name: "Gundam", price: 500000, dateAdded: Date()),
            Wishlist(name: "Game", price: 1000000, dateAdded: Date()),
            Wishlist(name: "Keyboard", price: 10000000, dateAdded: Date())
        ]
    }
}
