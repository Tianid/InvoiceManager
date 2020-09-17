//
//  Invoices.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//


struct Invoice {
    //MARK: - Properties
    var name: String
    var balance: Double
    var bills: [Bill]
    var income: Double
    var expense: Double
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
    
    mutating func setupNewData(index: Int? = nil, newValue: Bill) {
        if index != nil {
            setupDataByIndex(index: index!, newValue: newValue)
        } else {
            setupData(newValue: newValue)
        }
    }
    
    mutating func deleteDataByIndex(index: Int) {
        let oldValue = bills[index]
        
        if oldValue.value < 0 {
            expense -= oldValue.value
        } else {
            income -= oldValue.value
        }
        
        balance -= oldValue.value
        bills.remove(at: index)
        
    }
    
    private mutating func setupData(newValue: Bill) {
        let value = newValue.value
        if value < 0.0 {
            expense += value
        } else {
            income += value
        }
        
        balance += value
        bills.append(newValue)
    }
    
    private mutating func setupDataByIndex(index: Int,  newValue: Bill) {
        let oldValue = bills[index]
        let newBalance = balance - oldValue.value
        
        
        if oldValue.value < 0 {
            income += newValue.value
            expense -= oldValue.value
            
        } else {
            income -= oldValue.value
            expense += newValue.value
            
        }
        
        balance = newBalance + newValue.value
        bills[index] = newValue
    }
    
}
