//
//  AddWishlistView.swift
//  MoneyManager
//
//  Created by Arya Ilham on 08/02/24.
//

import SwiftUI

struct AddWishlistView: View {
    @State var itemName: String = ""
    @State var itemPrice: String = ""
    
    // TODO: - research how to implement generalization with @StateObject
    @ObservedObject private var viewModel: AddWishlistDefaultViewModel
    @Binding var shouldPresent: Bool
    
    init(viewModel: AddWishlistDefaultViewModel, shouldPresent: Binding<Bool>) {
        self.viewModel = viewModel
        self._shouldPresent = shouldPresent
    }
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea(.all)
            
            VStack(content: {
                Text("Add new wishlist")
                TextField("Item name", text: $itemName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 16)
                TextField("Item price", text: $itemPrice)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 16)
                Button("Save") {
                    viewModel.saveNewWishlist(name: itemName, price: itemPrice)
                    shouldPresent.toggle()
                }
                .padding()
                .padding(.horizontal, 16)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(16.0)
            })
            .padding()
        }
    }
}

//#Preview {
//    @State var testBind: Bool = false
//    AddWishlistView(viewModel: AddWishlistDefaultViewModel(refresh: $testBind))
//}
