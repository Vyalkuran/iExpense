//
//  ExpensesSection.swift
//  iExpense
//
//  Created by sebastian.popa on 8/8/23.
//

import SwiftUI

struct ExpensesSection: View {
    
    let sectionTitle: String
    
    let expensesList: [ExpenseItem]
    
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section{
            List {
                ForEach(expensesList) { item in
                    HStack {
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: item.currency))
                            .foregroundColor(item.amount < 10 ? .green : (item.amount < 100 ? .yellow : .red))
                    }
                }
                .onDelete(perform: deleteItems)
            }
        } header: {
                Text(sectionTitle)
                    .font(.title)
        }
    }
}

struct ExpensesSection_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesSection(sectionTitle: "Personal Expenses", expensesList: [], deleteItems: {_ in })
    }
}
