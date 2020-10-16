//
//  Invoices.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

struct Invoice: Codable {
    //MARK: - Properties
    var name: String
    var balance: Double
    var bills: [Bill]
    var income: Double
    var expense: Double
    let currency: Currency
    let modifiedDate: Date
    let creationDate: Date
    let uuid: String
    
    //MARK: - Init
    
    internal init(name: String, balance: Double, bills: [Bill], income: Double, expense: Double, currency: Currency, modifiedDate: Date = Date(), creationDate: Date = Date(), uuid: String = UUID().uuidString ) {
        self.name = name
        self.balance = balance
        self.bills = bills
        self.income = income
        self.expense = expense
        self.currency = currency
        self.modifiedDate = modifiedDate
        self.creationDate = creationDate
        self.uuid = uuid
    }
    
    init(data: (String, Currency, String?)) {
        self.name = data.0
        self.balance = Double(data.2 ?? "0") ?? 0.0
        self.bills = []
        self.income = 0
        self.expense = 0
        self.currency = data.1
        self.modifiedDate = Date()
        self.creationDate = Date()
        self.uuid = UUID().uuidString 
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
        
        
        if oldValue.value < 0 && newValue.value < 0 {
            expense -= oldValue.value
            expense += newValue.value
            
        } else if oldValue.value < 0 && newValue.value >= 0 {
            expense -= oldValue.value
            income += newValue.value
            
        } else if oldValue.value >= 0 && newValue.value < 0 {
            income -= oldValue.value
            expense += newValue.value
            
        } else if oldValue.value >= 0 && newValue.value >= 0 {
            income -= oldValue.value
            income += newValue.value
            
        }
        
        balance = newBalance + newValue.value
        bills[index] = newValue
    }
}
