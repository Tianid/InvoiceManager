//
//  Invoices.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//


struct Invoice {
    //MARK: - Properties
    let name: String
    let balance: Double
    var bills: [Bill]
    let income: Double
    let expense: Double
    let currency: Currency
    
    //MARK: - Init
    
    internal init(name: String, balance: Double, bills: [Bill], income: Double, expense: Double, currency: Currency) {
        self.name = name
        self.balance = balance
        self.bills = bills
        self.income = income
        self.expense = expense
        self.currency = currency
    }
    
    init(data: (String, Currency)) {
        self.name = data.0
        self.balance = 0
        self.bills = []
        self.income = 0
        self.expense = 0
        self.currency = data.1
    }
    //MARK: - Func
    
}
