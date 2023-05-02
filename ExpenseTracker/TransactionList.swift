//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Azmat Ali Akhtar on 02/05/2023.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM  :  TransactionListViewModel
    var body: some View {
        VStack{
            
            List{
                ForEach(Array(transactionListVM.groupTransactionByMonth()), id: \.key) { month , transaction in
                    Section {
                        ForEach(transactionListVM.transaction) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } header: {
                        Text(month)
                    }.listSectionSeparator(.hidden)

                   
                }
            }.listStyle(.plain)
            
        }.navigationTitle("Transactions")
            .navigationViewStyle(.stack)
           
    }
}

struct TransactionList_Previews: PreviewProvider {
    static let transactionListVM : TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transaction = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        NavigationView {
            TransactionList()
                .environmentObject(transactionListVM)
        }
    }
}
