//
//  CoreDataManagerMock.swift
//  InvoiceManagerTests
//
//  Created by Tianid on 03.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
@testable import InvoiceManager

class CoreDataManagerMock: ICoreDataManager {
    func createNewInvoice(data: (String, Currency, String?)) -> Result<Invoice, Error> {
        let invoice = Invoice(data: ("Foo", .BYN, nil))
        return .success(invoice)
    }
    
    func createNewBill(bill: Bill, invoice: Invoice) -> Result<Void, CoreDataSaveError> {
        return .success(())
    }
    
    func updateBill(bill: Bill) -> Result<Void, CoreDataSaveError> {
        return .success(())
    }
    
    func updateInvoice(invoice: Invoice) -> Result<Void, CoreDataSaveError> {
        return .success(())
    }
    
    func fetchAllInvoicesWithAllBills(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [Invoice] {
        return []
    }
    
    func fetchAllSectionsWitAllCategorys() -> [SuperSection] {
        return []
    }
    
    func fetchBillsWithInvoices(by category: InvoiceManager.Category) -> [Invoice] {
        return []
    }
    
    func deleteInvoice(invoice: Invoice) -> Result<Void, CoreDataSaveError> {
        return .success(())
    }
    
    func deleteBill(bill: Bill) -> Result<Void, CoreDataSaveError> {
        return .success(())
    }
    
    
}
