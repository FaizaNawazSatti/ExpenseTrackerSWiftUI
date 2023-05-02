//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Azmat Ali Akhtar on 02/05/2023.
//

import SwiftUI
import SwiftUICharts
struct ContentView: View {
    @EnvironmentObject var transactionListVM  :  TransactionListViewModel
     var body: some View {
        
        NavigationView {
            ScrollView {
                VStack (alignment: .leading, spacing: 24) {
                    
                    // MARK: Title
                    Text("Overview")
                        .font (.title2)
                        .bold()
                    
                    // MARK: Charts
                    let data = transactionListVM.accumulateTransactions()
                    if !data.isEmpty{
                        let totalExpenses = data.last?.1
                        CardView{
                            VStack(alignment: .leading) {
                                ChartLabel(totalExpenses?.formatted(.currency(code: "USD")) ?? "0" , type: .title)
                                LineChart()
                            }
                            .background(Color.systemBackground)
                            
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4) , Color.icon)))
                        .frame(height: 300)
                       
                    }
                   
                    
                    // MARK: Transaction List
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background (Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Notification Icon
                ToolbarItem {
                    Image (systemName: "bell.badge")
                        .symbolRenderingMode (.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
            }
            .navigationTitle("Expense Tracker")
        }.navigationViewStyle(.stack)
            .accentColor(.primary)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM : TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transaction = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        ContentView()
            .environmentObject(transactionListVM)
    }
}
