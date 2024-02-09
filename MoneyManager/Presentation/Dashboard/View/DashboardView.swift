//
//  DashboardView.swift
//  MoneyManager
//
//  Created by Arya Ilham on 08/02/24.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject var viewModel: DashboardDefaultViewModel  
    
    @State var shouldRefresh: Bool = false
    @State var isAddWishlistShown: Bool = false

    @State var selectedWishlist: Wishlist?

    init(viewModel: DashboardDefaultViewModel = DashboardDefaultViewModel()) {
        self.viewModel = viewModel
        viewModel.getCurrentWishlist()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(content: {
                    savingsHighlight
                    mostExpensiveWishlist
                    Spacer()
                })
                VStack(content: {
                    if isAddWishlistShown {
                        Spacer()
                        AddWishlistView(viewModel: AddWishlistDefaultViewModel(refresh: $shouldRefresh), shouldPresent: $isAddWishlistShown)
                            .padding(.top, 100)
                            .transition(.move(edge: .bottom))
                            .animation(.spring)
                            .fixedSize(horizontal: false, vertical: true)
                            .ignoresSafeArea()
                    }
                    
                    if let selectedWishlist = selectedWishlist {
                        Spacer()
                        BuyWishlistConfirmation(viewModel: self.viewModel, selectedWishlist: $selectedWishlist)
                            .padding(.top, 100)
                            .transition(.move(edge: .bottom))
                            .animation(.spring)
                            .fixedSize(horizontal: false, vertical: true)
                            .ignoresSafeArea()
                    }
                }).zIndex(3.0)
            }
            .onChange(of: shouldRefresh, perform: { value in
                if shouldRefresh {
                    viewModel.getCurrentWishlist()
                    shouldRefresh = false
                }
            })
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isAddWishlistShown.toggle()
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
            
            List {
                ForEach(viewModel.wishlist) { wish in
                    MostExpensiveWishlistView(itemName: wish.name, itemPrice: "Rp \(wish.price)", daysPassedAfterAdded: wish.dateAdded)
                        .onTapGesture {
                            selectedWishlist = wish
                        }
                }
                .onDelete(perform: { indexSet in
                    viewModel.delete(indexSet)
                })
            }
            .listStyle(.plain)
        }
    }
    
    var savingsHighlight: some View {
        ZStack(content: {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.black)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Current wishlist value:")
                        .font(.headline)
                    Text(viewModel.currentWishlistValue)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 16)
                    
                    Text("Days since the last spendings:")
                        .font(.headline)
                    Text("\(viewModel.currentStreak) Day(s)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding(32)
                Spacer()
            }
        })
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal, 16)
        .foregroundColor(.white)
    }
}

struct BuyWishlistConfirmation: View {
    @ObservedObject var viewModel: DashboardDefaultViewModel
    @Binding var selectedWishlist: Wishlist?
    
    var body: some View {
        ZStack(content: {
            Color.white
                .ignoresSafeArea()
            
            VStack(content: {
                Text("Are you sure you want to purchase this items? this will reset your progress")
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .padding(.bottom, 16)
                
                HStack(content: {
                    Text("Price")
                    Spacer()
                    Text("Rp. 100000")
                })
                .padding(.bottom, 8)
                HStack(content: {
                    Text("Name")
                    Spacer()
                    Text("Gundam")
                })
                .padding(.bottom, 8)
                HStack(content: {
                    Text("Days spent to hold the urge")
                    Spacer()
                    Text("10 days")
                })
                .padding(.bottom, 16)
                
                Button("I no longer can hold the urge") {
                    if let itemToPurchase = selectedWishlist {
                        viewModel.purchase(itemToPurchase)
                        selectedWishlist = nil
                    }
                }
                .padding()
                .padding(.horizontal, 16)
                .foregroundColor(.white)
                .background(
                    Color.red
                        .frame(width: .infinity, height: .infinity)
                )
                .cornerRadius(16.0)
                
                Button("I still can hold the urge") {
                    selectedWishlist = nil
                }
                .padding()
                .padding(.horizontal, 16)
                .foregroundColor(.white)
                .background(
                    Color.green
                        .frame(width: .infinity, height: .infinity)
                )
                .cornerRadius(16.0)

            })
            .padding()
        })
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
        .padding(.bottom, 8)
    }
}

#Preview {
    DashboardView(viewModel: DashboardDefaultViewModel())
}
