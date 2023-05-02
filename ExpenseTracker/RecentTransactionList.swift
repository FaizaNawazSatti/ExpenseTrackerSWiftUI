//
//  RecentTransactionList.swift
//  ExpenseTracker
//
//  Created by Azmat Ali Akhtar on 02/05/2023.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionListVM  :  TransactionListViewModel
    var body: some View {
        
            VStack{
                HStack{
                    Text("Recent Transactions")
                        .bold()
                    
                    Spacer()
                    
                    NavigationLink {
                        TransactionList()
                    } label: {
                        HStack(spacing : 4){
                            Text("See All")
                            Image(systemName: "chevron.right")
                        }.foregroundColor(Color.text)
                    }

                }
                .padding(.top)
                
                ForEach(Array(transactionListVM.transaction.prefix(5).enumerated()), id: \.element) { index , transaction in
                    TransactionRow(transaction: transaction)
                    Divider()
                        .opacity(index == 4 ? 0 : 1)
                }
            }
            .padding()
            .background(Color.systemBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20 , style: .continuous))
        .shadow(color: Color.primary.opacity(0.5),radius: 10 ,x: 0,y: 5)
        
    }
}

struct RecentTransactionList_Previews: PreviewProvider {
    static let transactionListVM : TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transaction = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        NavigationView {
            RecentTransactionList()
                .environmentObject(transactionListVM)
        }
    }
}
