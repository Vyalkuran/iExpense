//
//  AddView.swift
//  iExpense
//
//  Created by sebastian.popa on 8/7/23.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = "USD"
    
    @State private var hasFieldsBeenOmitted = false
    
    @AppStorage("defaultCurrency") private var defaultCurrency = "USD"
    
    @Environment(\.dismiss) var dismiss
    
    let types = ["Business", "Personal"]
    
    let currencies = NSLocale.isoCurrencyCodes
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id:\.self){
                        Text($0)
                    }
                }
                
                Picker("Currency", selection: $currency) {
                    ForEach(currencies, id:\.self){
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: currency))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Picker("Default Currency", selection: $defaultCurrency){
                    ForEach(currencies, id:\.self){
                        Text($0)
                    }
                }
                .onChange(of: defaultCurrency) { _ in
                    currency = defaultCurrency
                }
                
                Button("Save") {
                    saveItem()
                }
            }
        }
        .onAppear {
            currency = defaultCurrency
        }
        .alert("You have incomplete information", isPresented: $hasFieldsBeenOmitted){
            Button("OK", role: .cancel){ }
        } message: {
            Text("Please make sure you've filled out the name and the amount of the expense")
        }
    }
    
    func saveItem() {
        if name.isEmpty || amount == 0{
            hasFieldsBeenOmitted = true
            return
        }
        let item = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
        expenses.items.append(item)
        dismiss()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
