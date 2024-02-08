//
//  DashboardView.swift
//  MoneyManager
//
//  Created by Arya Ilham on 08/02/24.
//

import SwiftUI

struct DashboardView: View {
    
    var viewModel: DashboardViewModel
    
    @AppStorage("currentWishlistValue") var currentWishlistValue: String = "Rp 3.000.000"
    @AppStorage("currentDaysStreak") var currentDaysStreak: Int = 0
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(content: {
                    savingsHighlight
                    mostExpensiveWishlist
                    Spacer()
                })
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // TODO: - open add new wishlist page
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }
    }
    
    var mostExpensiveWishlist: some View {
        VStack(alignment: .leading) {
            Text("Current wishlist")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 16)
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.wishlist) { wish in
                        MostExpensiveWishlistView(itemName: wish.name, itemPrice: "Rp \(wish.price)", daysPassedAfterAdded: wish.dateAdded)
                    }
                }
                .listStyle(.plain)
            }
        }
    }
    
    var savingsHighlight: some View {
        ZStack(content: {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.black)
                .frame(height: .infinity)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Current wishlist value:")
                        .font(.headline)
                    Text(currentWishlistValue)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 16)
                    
                    Text("Days since the last spendings:")
                        .font(.headline)
                    Text("\(currentDaysStreak) Day(s)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .frame(width: .infinity)
                .padding(32)
                Spacer()
            }
        })
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal, 16)
        .foregroundColor(.white)
    }
}

struct MostExpensiveWishlistView: View {
    
    let itemName: String
    let itemPrice: String
    let daysPassedAfterAdded: Date
    
    init(itemName: String, itemPrice: String, daysPassedAfterAdded: Date) {
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.daysPassedAfterAdded = daysPassedAfterAdded
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(.blue)
            
            HStack(content: {
                VStack(alignment: .leading) {
                    Text(itemName)
                        .font(.title2)
                    Text(itemPrice)
                        .font(.title2)
                }
                Spacer()
                //                Text("\(daysPassedAfterAdded)")
            })
            .padding()
            .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}

#Preview {
    DashboardView(viewModel: DashboardDefaultViewModel())
}
