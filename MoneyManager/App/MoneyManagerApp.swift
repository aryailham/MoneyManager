//
//  MoneyManagerApp.swift
//  MoneyManager
//
//  Created by Arya Ilham on 08/02/24.
//

import SwiftUI

@main
struct MoneyManagerApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView(viewModel: DashboardDefaultViewModel())
        }
    }
}
