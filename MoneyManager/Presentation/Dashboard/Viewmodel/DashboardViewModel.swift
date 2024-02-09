//
//  DashboardViewModel.swift
//  MoneyManager
//
//  Created by Arya Ilham on 08/02/24.
//

import Foundation
import SwiftUI

protocol DashboardViewModelInput {
    func getCurrentWishlist()
    func delete(_ indexSet: IndexSet)
}

protocol DashboardViewModelOutput {
    var wishlist: [Wishlist] { get }
    func countTotalWishlistValue()
}

typealias DashboardViewModel = DashboardViewModelInput & DashboardViewModelOutput & ObservableObject

class DashboardDefaultViewModel: DashboardViewModel {
    
    private let repository: WishlistRepository

    @Published var currentWishlistValue: String = "Rp 3.000.000"
    @Published var currentStreak: Int = 0
    @Published var wishlist: [Wishlist] = []
    
    init(repository: WishlistRepository = WishlistDefaultRepository()) {
        self.repository = repository
    }
    
    func getCurrentWishlist() {
        wishlist = repository.getWishlist()
        countTotalWishlistValue()
    }
    
    func countTotalWishlistValue() {
        var total = 0
        wishlist.forEach { wish in
            total += wish.price
        }
        currentWishlistValue = "Rp \(total)"
    }
    
    func delete(_ indexSet: IndexSet) {
        wishlist.remove(atOffsets: indexSet)
    }
}
