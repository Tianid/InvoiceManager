//
//  TestData.swift
//  InvoiceManager
//
//  Created by Tianid on 03.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation


var testSingleCategory = Category(name: "TEST CATEGORY", iconImage: "NO IMAGE", section: .init(name: "TEST SECTION"))
var testBills1 = [
    Bill(value: 100, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -100, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: 200, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -200, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: 300, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -300, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: 999, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -368, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date())
]

var testBills2 = [
    Bill(value: -300, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: 999, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -368, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date())
]

var testBills3 = [
    Bill(value: -368, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date())
]

var testBills4 = [
    Bill(value: 100, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -100, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: 200, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -200, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: 300, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -300, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: 999, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -368, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date())
]

var testBills5 = [
    Bill(value: 100, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -100, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: 200, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -200, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: 300, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -300, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: 999, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -368, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date())
]

var testBills6 = [
    Bill(value: 1111111, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -100, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: 200, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -200, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: 300, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -300, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: 999, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date()),
    Bill(value: -368, currency: .RUB, billName: "SOME NAME", billDescription: "SOME DESCRIPTION", category: testSingleCategory , modifiedDate: Date())
]

var testInvoices = [
    Invoice(name: "TEST INVOICE #1", balance: 0, bills: testBills1, income: 0, expense: 0, currency: .RUB),
    Invoice(name: "TEST INVOICE #2", balance: 0, bills: testBills2, income: 0, expense: 0, currency: .RUB),
    Invoice(name: "TEST INVOICE #3", balance: 0, bills: testBills3, income: 0, expense: 0, currency: .RUB),
    Invoice(name: "TEST INVOICE #4", balance: 0, bills: testBills4, income: 0, expense: 0, currency: .RUB),
    Invoice(name: "TEST INVOICE #5", balance: 0, bills: testBills5, income: 0, expense: 0, currency: .RUB),
    Invoice(name: "TEST INVOICE #6", balance: 0, bills: testBills6, income: 0, expense: 0, currency: .RUB)
]


var testCurrency: [Currency] = [.EUR, .GBP, .RUB, .USD]
