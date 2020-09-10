//
//  Bill.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import Foundation

struct Bill {
    internal init(value: Double, currency: Currency, billName: String, billDescription: String, category: Category, modifiedDate: Date = Date()) {
        self.value = value
        self.currency = currency
        self.billName = billName
        self.billDescription = billDescription
        self.category = category
        self.modifiedDate = modifiedDate
    }
    
    //MARK: - Properties
    let value: Double
    let currency: Currency
    let billName: String
    let billDescription: String
    let category: Category
    let modifiedDate: Date
    //MARK: - Init
    //MARK: - Func
    
    func initWith(category: Category) -> Bill {
        let bill = Bill(value: self.value,
                        currency: self.currency,
                        billName: self.billName,
                        billDescription: self.billDescription,
                        category: category,
                        modifiedDate: self.modifiedDate)
        return bill
    }
}
