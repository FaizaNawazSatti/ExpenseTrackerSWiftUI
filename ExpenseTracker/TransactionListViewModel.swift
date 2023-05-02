//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Azmat Ali Akhtar on 02/05/2023.
//

import Foundation
import Collections

typealias TransactionGroup = OrderedDictionary<String , [Transaction]>
typealias TransactionPrefixSum = [(String,Double)]

final class TransactionListViewModel : ObservableObject{
    @Published var transaction : [Transaction] = []
    init() {
        Task.init {
            await getTransaction()
        }
    }
    func getTransaction() async {
        do {
            guard let url = URL(string: "https://designcode.io/data/transactions.json") else { fatalError("Missing URL") }
            
            
            let urlRequest = URLRequest(url: url)
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            
            let decodedData = try JSONDecoder().decode([Transaction].self, from: data)
            DispatchQueue.main.async {
                
                self.transaction = []
                dump(decodedData)
                
                self.transaction = decodedData
            }
            
        } catch {
            // If we run into an error, print the error in the console
            print("Error fetching data from Pexels: \(error)")
        }
    }
    
    func groupTransactionByMonth() -> TransactionGroup{
        
        guard !transaction.isEmpty else {return [:]}
        let groupedTransaction = TransactionGroup(grouping: transaction) { $0.month }
        return groupedTransaction
    }
    
    func accumulateTransactions() -> TransactionPrefixSum{
        
        guard !transaction.isEmpty else {return []}
        let today = "02/07/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        
        var sum : Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24){
            let dailyExpenses = transaction.filter({ $0.dateParsed == date && $0.isExpense })
            let dailyTotal = dailyExpenses.reduce(0){$0 - $1.signedAmount}
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(),sum))
        }
       return cumulativeSum
    }
}
