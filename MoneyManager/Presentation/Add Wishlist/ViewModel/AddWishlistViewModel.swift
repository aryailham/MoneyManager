//
//  AddWishlistViewModel.swift
//  MoneyManager
//
//  Created by Arya Ilham on 08/02/24.
//

import Foundation
import SwiftUI
import CoreData

protocol AddWishlistViewModelInput {
    func saveNewWishlist(name: String, price: String)
}

typealias AddWishlistViewModel = AddWishlistViewModelInput & ObservableObject

class AddWishlistDefaultViewModel: AddWishlistViewModel {
    private let repository: WishlistRepository
    
    @Binding var shouldDashboardRefresh: Bool
    
    init(repository: WishlistRepository = WishlistDefaultRepository(), refresh: Binding<Bool>) {
        self.repository = repository
        self._shouldDashboardRefresh = refresh
    }
    
    func saveNewWishlist(name: String, price: String) {
        let wish = Wishlist(name: name, price: Int(price) ?? 0, dateAdded: Date())
        repository.saveNewWishlist(wish)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.shouldDashboardRefresh = true
        }
    }
}
