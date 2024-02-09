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
    func purchase(_ selectedWishlist: Wishlist)
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
    
    @State var data: String = ""
    
    init(repository: WishlistRepository = WishlistDefaultRepository()) {
        self.repository = repository
    }
    
    func getCurrentWishlist() {
        wishlist = repository.getWishlist()
        countTotalWishlistValue()
        getDaysAfterLastSpending()
    }
    
    func countTotalWishlistValue() {
        var total = 0
        wishlist.forEach { wish in
            total += wish.price
        }
        currentWishlistValue = "Rp \(total)"
    }
    
    func delete(_ indexSet: IndexSet) {
        if let index = indexSet.first {
            let IDToDelete = wishlist[index].id
            
            repository.delete(id: IDToDelete) { isSuccess in
                switch isSuccess {
                case true:
                    self.countTotalWishlistValue()
                    DispatchQueue.main.async {
                        self.wishlist.remove(atOffsets: indexSet)
                    }
                case false:
                    print("failed to delete")
                }
            }
        }
    }
    
    func getDaysAfterLastSpending() {
        let helper = DateHelper()
        if let lastSpendingDate = UserDefaults.standard.string(forKey: "lastSpendingDate"),
           let date = helper.convertToDate(lastSpendingDate){
            let daysPassedSinceLastSpending = helper.daysBetweenDate(from: date, to: Date())
            currentStreak = daysPassedSinceLastSpending
        } else {
            currentStreak = 0
        }
    }
    
    func purchase(_ selectedWishlist: Wishlist) {
        repository.delete(id: selectedWishlist.id) { isSuccess in
            if isSuccess {
                self.resetCounter()
                self.getCurrentWishlist()
            }
        }
    }
    
    func resetCounter() {
        UserDefaults.standard.setValue("\(Date())", forKey: "lastSpendingDate")
    }
}
