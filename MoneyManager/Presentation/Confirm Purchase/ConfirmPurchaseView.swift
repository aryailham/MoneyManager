//
//  ConfirmPurchaseView.swift
//  MoneyManager
//
//  Created by Arya Ilham on 09/02/24.
//

import SwiftUI

struct ConfirmPurchaseView: View {
    @ObservedObject var viewModel: DashboardDefaultViewModel
    
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
                    viewModel.purchase()
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
                    viewModel.selectedWishlist = nil
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
