//
//  ExpenseItem.swift
//  iExpense
//
//  Created by sebastian.popa on 8/7/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currency: String
}
