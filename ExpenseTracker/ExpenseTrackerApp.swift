//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Azmat Ali Akhtar on 02/05/2023.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    
    @StateObject var transactionListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
