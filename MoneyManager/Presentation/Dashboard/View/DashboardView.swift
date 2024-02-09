//
//  DashboardView.swift
//  MoneyManager
//
//  Created by Arya Ilham on 08/02/24.
//

import SwiftUI

enum ShowedDashboardPopUp {
    case add
    case purchase
}

struct DashboardView: View {
    
    @ObservedObject var viewModel: DashboardDefaultViewModel
    
    @State var shouldRefresh: Bool = false
    @State var isAddWishlistShown: Bool = false
    
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
                    if isAddWishlistShown && viewModel.selectedWishlist == nil {
                        Spacer()
                        AddWishlistView(viewModel: AddWishlistDefaultViewModel(refresh: $shouldRefresh), shouldPresent: $isAddWishlistShown)
                            .padding(.top, 100)
                            .transition(.move(edge: .bottom))
                            .animation(.spring)
                            .fixedSize(horizontal: false, vertical: true)
                            .ignoresSafeArea()
                    }
                    
                    if let selectedWishlist = viewModel.selectedWishlist {
                        Spacer()
                        ConfirmPurchaseView(viewModel: self.viewModel)
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
                        if viewModel.selectedWishlist == nil {
                            isAddWishlistShown.toggle()
                        }
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
                    MostExpensiveWishlistView(itemName: wish.name, itemPrice: "Rp \(wish.price)", addedDate: wish.dateAdded, shouldPriceShowed: $shouldValueHidden)
                        .onTapGesture {
                            viewModel.selectedWishlist = wish
                        }
                }
                .onDelete(perform: { indexSet in
                    viewModel.delete(indexSet)
                })
            }
            .listStyle(.plain)
        }
    }
    
    @State var shouldValueHidden: Bool = true
    var savingsHighlight: some View {
        ZStack(content: {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.black)
            
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .center, content: {
                            Text("Current wishlist value:")
                                .font(.headline)
                            Button(action: {
                                shouldValueHidden.toggle()
                            }, label: {
                                Image(systemName: shouldValueHidden ? "eye.fill" : "eye.slash.fill")
                                    .frame(height: .infinity, alignment: .center)
                            })

                        })
                        Text(shouldValueHidden ? "Rp ******" : viewModel.currentWishlistValue)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Days since the last spendings:")
                            .font(.headline)
                        Text("\(viewModel.currentStreak) Day(s)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
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

struct MostExpensiveWishlistView: View {
    
    @Binding var shouldPriceShowed: Bool
    
    let itemName: String
    let itemPrice: String
    let addedDate: Date
    
    init(itemName: String, itemPrice: String, addedDate: Date, shouldPriceShowed: Binding<Bool>) {
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.addedDate = addedDate
        self._shouldPriceShowed = shouldPriceShowed
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(.blue)
            
            HStack(content: {
                VStack(alignment: .leading) {
                    Text(itemName)
                        .font(.title2)
                    Text(shouldPriceShowed ? "Rp ******" : itemPrice)
                        .font(.title2)
                }
                Spacer()
                Text("\(DateHelper().daysBetweenDate(from: addedDate, to: Date())) Day(s)")
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
