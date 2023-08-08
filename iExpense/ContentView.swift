//
//  ContentView.swift
//  iExpense
//
//  Created by sebastian.popa on 8/7/23.
//

import SwiftUI

struct User : Codable {
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    
    @StateObject private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var businessExpenses: [ExpenseItem] {
        expenses.items.filter {
            $0.type == "Business"
        }
    }
    
    var personalExpenses: [ExpenseItem] {
        expenses.items.filter {
            $0.type == "Personal"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ExpensesSection(sectionTitle: "Personal Expenses", expensesList: personalExpenses, deleteItems: removePersonalItems)
                
                ExpensesSection(sectionTitle: "Business Expenses", expensesList: businessExpenses, deleteItems: removeBusinessItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]){
        
        var objectsToDelete = IndexSet()
        
        for offset in offsets {
            let item = inputArray[offset]
            
            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }
        
        expenses.items.remove(atOffsets: objectsToDelete)
    }
    
    func removePersonalItems(at offsets: IndexSet){
        removeItems(at: offsets, in: personalExpenses)
    }
    
    func removeBusinessItems(at offsets: IndexSet){
        removeItems(at: offsets, in: businessExpenses)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}
