//
//  CoreDataManager.swift
//  InvoiceManager
//
//  Created by Tianid on 25.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import CoreData

protocol ICoreDataManager {
    func createNewInvoice(data: (String, Currency, String?)) -> Result<Bool, Error>
    func fetchAllInvoices() -> [CDInvoice]
    func fetchAllCategorys() -> [CDCategory]
    func createNewBill(value: Double, billName: String, billDescription: String, category: CDCategory, invoice: CDInvoice) -> Result<Bool, Error>
}

class CoreDataManager {
    //MARK: - Properties
    private var context: NSManagedObjectContext
    //MARK: - Init
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    //MARK: - Func
    
    private func transformModelCDCategory(model: CDInvoice) -> Invoice {
        let name = model.name ?? ""
        let currencyStr = model.currency ?? ""
        let currency = Currency(rawValue: currencyStr != "" ? currencyStr : Currency.none.rawValue)!
        let invoice = Invoice(name: name,
                              balance: model.balance,
                              bills: [],
                              income: model.income,
                              expense: model.expense,
                              currency: currency)
        
        
        return invoice
    }
}

extension CoreDataManager: ICoreDataManager {
    func createNewBill(value: Double, billName: String, billDescription: String, category: CDCategory, invoice: CDInvoice) -> Result<Bool, Error> {
        let bill = CDBill(context: context)
        bill.value = value
        bill.billName = billName
        bill.billDescription = billDescription
        bill.category = category
        bill.modifiedDate = Date()
        
        invoice.addToBills(bill)
        
        do {
            try context.save()
            return .success(true)
        } catch {
            print(error.localizedDescription)
            return .failure(error)
        }
    }
    
    
    func fetchAllCategorys() -> [CDCategory] {
        let request = NSFetchRequest<CDCategory>(entityName: "\(CDCategory.self)")
        do {
            let data = try context.fetch(request)
            return data
            
            
        } catch {
            print(error.localizedDescription)
            return []
        }
        
    }
    
    
    func fetchAllInvoices() -> [CDInvoice] {
        let request = NSFetchRequest<CDInvoice>(entityName: "\(CDInvoice.self)")
        
        do {
            let data = try context.fetch(request)
            return data
            //            var array: [Invoice] = []
            //            for item in data {
            //                array.append(transformModelCDCategory(model: item))
            //            }
            //
            //            return array
            
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func createNewInvoice(data: (String, Currency, String?)) -> Result<Bool, Error> {
        let invoice = CDInvoice(context: context)
        invoice.name = data.0
        invoice.balance = Double(data.2 ?? "0") ?? 0
        invoice.income = 0
        invoice.expense = 0
        invoice.currency = data.1.rawValue
        invoice.modifiedDate = Date()
        invoice.creationDate = Date()
        
        do {
            try context.save()
            return .success(true)
        } catch {
            print(error.localizedDescription)
            return .failure(error)
        }
        
    }
}
