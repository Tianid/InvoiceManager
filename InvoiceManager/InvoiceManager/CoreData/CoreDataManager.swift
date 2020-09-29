//
//  CoreDataManager.swift
//  InvoiceManager
//
//  Created by Tianid on 25.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

enum CoreDataSaveError: Error {
    case notGetAllData
    case saveError
}

import Foundation
import CoreData

protocol ICoreDataManager {
    func createNewInvoice(data: (String, Currency, String?)) -> Result<Invoice, Error>
    func createNewBill(bill: Bill, invoice: Invoice) -> Result<Void, CoreDataSaveError>
    
    func updateBill(bill: Bill) -> Result<Void, CoreDataSaveError>
    func updateInvoice(invoice: Invoice) -> Result<Void, CoreDataSaveError>

    func fetchAllCategorys() -> [Category]
    func fetchAllInvoicesWithAllBills() -> [Invoice]
    
    func deleteInvoice(invoice: Invoice) -> Result<Void, CoreDataSaveError>
    func deleteBill(bill: Bill) -> Result<Void, CoreDataSaveError>
}


class CoreDataManager {
    //MARK: - Properties
    private var context: NSManagedObjectContext
    //MARK: - Init
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    //MARK: - Func
    //MARK: - Transform CD entitites to App entities
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
    
    private func transformCDBillModelToAppBillModel(cdBill: CDBill, cdCurrency: String) -> Bill {
        let bill = Bill(value: cdBill.value,
        currency: Currency(rawValue: cdCurrency) ?? .none,
        billName: cdBill.billName ?? "",
        billDescription: cdBill.billDescription ?? "",
        category: Category(name: (cdBill.category?.name)!,
                           iconImage: (cdBill.category?.iconImageName)!,
                           section: Section(name: (cdBill.category?.section?.name)!)),
        modifiedDate: cdBill.modifiedDate ?? Date(),
        creationDate: cdBill.creationDate ?? Date())
        return bill
    }
    
    private func transformCDInvoiceModelToAppInvoiceModel(cdInvoice: CDInvoice, billsArray: [Bill]) -> Invoice {
        let invoice = Invoice(name: cdInvoice.name!,
                              balance: cdInvoice.balance,
                              bills: billsArray,
                              income: cdInvoice.income,
                              expense: cdInvoice.expense,
                              currency: Currency(rawValue: cdInvoice.currency!)!,
                              modifiedDate: cdInvoice.modifiedDate ?? Date(),
                              creationDate: cdInvoice.creationDate ?? Date())
        return invoice
    }
    
    private func transformCDCategoryModelToAppCategoryModel(cdCategory: CDCategory) -> Category {
        let category = Category(name: cdCategory.name!,
                                iconImage: cdCategory.iconImageName!,
                                section: Section(name: (cdCategory.section?.name!)!))
        return category
    }
    
    //MARK: - Transform App entitites to CD entities
    
    private func transformAppBillModelToCDBillModel(bill: Bill, updatableBill: CDBill? = nil) -> CDBill? {
        
        guard let category = fetchCategory(with: NSPredicate(format: "name == %@", "\(bill.category.name)")) else { return nil }
        
        let cdBill: CDBill!
        if updatableBill == nil {
            cdBill = CDBill(context: context)
        } else {
            cdBill = updatableBill
        }
        
        cdBill.value = bill.value
        cdBill.billName = bill.billName
        cdBill.billDescription = bill.billDescription
        cdBill.category = category[0]
        cdBill.modifiedDate = bill.modifiedDate
        cdBill.creationDate = bill.creationDate
        
        return cdBill
    }
    
    //MARK: - Fetch with predicate
    
    private func fetchInvoice(with predicate: NSPredicate?) -> [CDInvoice]? {
        let request = NSFetchRequest<CDInvoice>(entityName: "\(CDInvoice.self)")
        request.predicate = predicate

        do {
            let cdInovice = try context.fetch(request)
            return cdInovice
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    private func fetchCategory(with predicate: NSPredicate) -> [CDCategory]? {
        let request = NSFetchRequest<CDCategory>(entityName: "\(CDCategory.self)")
        request.predicate = predicate

        do {
            let cdCategory = try context.fetch(request)
            return cdCategory
        } catch {
            print(error)
            return nil
        }
    }

    private func fetchBill(with predicate: NSPredicate?) -> [CDBill]? {
        let request = NSFetchRequest<CDBill>(entityName: "\(CDBill.self)")
        request.predicate = predicate

        do {
            let cdBill = try context.fetch(request)
            return cdBill
        } catch {
            print(error)
            return nil
        }
    }
    
    //MARK: - Update entities
    
    private func makeUpdateInvoiceName(invoice: Invoice) {
        guard let cdInvoices = fetchInvoice(with: NSPredicate(format: "creationDate == %@", invoice.creationDate as NSDate)), cdInvoices.count > 0 else { return }
        let cdInvoice = cdInvoices[0]
        cdInvoice.name = invoice.name
        cdInvoice.modifiedDate = Date()
    }
    
    private func makeUpdateInvoiceByNewBill(cdInvoice: CDInvoice, by bill: CDBill) {
        
        let value = bill.value
        if value < 0.0 {
            cdInvoice.expense += value
        } else {
            cdInvoice.income += value
        }
        
        cdInvoice.balance += value
        cdInvoice.modifiedDate = Date()
    }
    
    private func makeUpdateInvoiceByChangedBill(invoice: CDInvoice, oldBill: CDBill, newBill: Bill) {
        let oldValue = oldBill
        let newValue = newBill
        let newBalance = invoice.balance - oldBill.value
        
        
        if oldValue.value < 0 && newValue.value < 0 {
            invoice.expense -= oldValue.value
            invoice.expense += newValue.value
            
        } else if oldValue.value < 0 && newValue.value >= 0 {
            invoice.expense -= oldValue.value
            invoice.income += newValue.value
            
        } else if oldValue.value >= 0 && newValue.value < 0 {
            invoice.income -= oldValue.value
            invoice.expense += newValue.value
            
        } else if oldValue.value >= 0 && newValue.value >= 0 {
            invoice.income -= oldValue.value
            invoice.income += newValue.value
            
        }
        
        invoice.balance = newBalance + newValue.value
        invoice.modifiedDate = Date()
    }
    
    private func makeUpdateInvoiceByDeletingBill(cdInvoice: CDInvoice, cdBill: CDBill) {
        let oldValue = cdBill
        
        if oldValue.value < 0 {
            cdInvoice.expense -= oldValue.value
        } else {
            cdInvoice.income -= oldValue.value
        }
        
        cdInvoice.balance -= oldValue.value
        cdInvoice.modifiedDate = Date()
    }
}

extension CoreDataManager: ICoreDataManager {
    
    //MARK: - Create entitys
    func createNewInvoice(data: (String, Currency, String?)) -> Result<Invoice, Error> {
        let cdInvoice = CDInvoice(context: context)
        cdInvoice.name = data.0
        cdInvoice.balance = Double(data.2 ?? "0") ?? 0
        cdInvoice.income = 0
        cdInvoice.expense = 0
        cdInvoice.currency = data.1.rawValue
        cdInvoice.modifiedDate = Date()
        cdInvoice.creationDate = Date()
        
        do {
            try context.save()
            let invoice = transformCDInvoiceModelToAppInvoiceModel(cdInvoice: cdInvoice, billsArray: [])
            return .success(invoice)
        } catch {
            print(error.localizedDescription)
            return .failure(error)
        }
    }
    
    func createNewBill(bill: Bill, invoice: Invoice) -> Result<Void, CoreDataSaveError> {
        guard let cdInvoices = fetchInvoice(with: NSPredicate(format: "creationDate == %@", invoice.creationDate as NSDate)), !cdInvoices.isEmpty else { return .failure(.notGetAllData)}
        guard let cdBill = transformAppBillModelToCDBillModel(bill: bill) else { return .failure(.notGetAllData)}
        let cdInvoice = cdInvoices[0]
        makeUpdateInvoiceByNewBill(cdInvoice: cdInvoice, by: cdBill)
        cdInvoice.addToBills(cdBill)
        
        do {
            try context.save()
            return .success(())
        } catch {
            print(error)
            return .failure(.saveError)
        }
    }
    //MARK: - Update entitys

    func updateBill(bill: Bill) -> Result<Void, CoreDataSaveError> {
        guard let cdBills = fetchBill(with: NSPredicate(format: "creationDate == %@", bill.creationDate as NSDate)), cdBills.count > 0 else { return .failure(.notGetAllData)}
        guard let invoice = cdBills[0].invoice else { return .failure(.notGetAllData)}
        let cdBill = cdBills[0]
        makeUpdateInvoiceByChangedBill(invoice: invoice, oldBill: cdBill, newBill: bill)
        let _ = transformAppBillModelToCDBillModel(bill: bill, updatableBill: cdBill)
        
        do {
            try context.save()
            return .success(())
        } catch {
            print(error.localizedDescription)
            return .failure(.saveError)
        }
    }
    
    func updateInvoice(invoice: Invoice) -> Result<Void, CoreDataSaveError> {
        makeUpdateInvoiceName(invoice: invoice)
        do {
            try context.save()
            return .success(())
        } catch {
            print(error.localizedDescription)
            return .failure(.saveError)
        }
    }
    
    //MARK: - Fetch entitys
    
    func fetchAllCategorys() -> [Category] {
        let request = NSFetchRequest<CDCategory>(entityName: "\(CDCategory.self)")
        do {
            let cdCategorys = try context.fetch(request)
            var categorys: [Category] = []

            for cdCategory in cdCategorys {
                let category = transformCDCategoryModelToAppCategoryModel(cdCategory: cdCategory)
                categorys.append(category)
            }
            return categorys

        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    
    func fetchAllInvoicesWithAllBills() -> [Invoice] {
        let request = NSFetchRequest<CDInvoice>(entityName: "\(CDInvoice.self)")
        
        do {
            let data = try context.fetch(request)
            var invoices: [Invoice] = []
            
            for cdInvoice in data {
                let sortedBills = cdInvoice.bills?.sortedArray(using: [NSSortDescriptor(key: "creationDate", ascending: true)]) as? [CDBill]
                var billsArray: [Bill] = []
            
                for cdBill in sortedBills! {
                    let bill = transformCDBillModelToAppBillModel(cdBill: cdBill, cdCurrency: cdInvoice.currency!)
                    billsArray.append(bill)
                }
                
                let invoice = transformCDInvoiceModelToAppInvoiceModel(cdInvoice: cdInvoice, billsArray: billsArray)
                invoices.append(invoice)
            }
            return invoices
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    //MARK: - Delete entitys

    func deleteInvoice(invoice: Invoice) -> Result<Void, CoreDataSaveError> {
        guard let cdInvoices = fetchInvoice(with: NSPredicate(format: "creationDate == %@", invoice.creationDate as NSDate)), cdInvoices.count > 0 else { return .failure(.notGetAllData)}
        let cdInvoice = cdInvoices[0]
        context.delete(cdInvoice)
        
        do {
            try context.save()
            return .success(())
        } catch {
            print(error.localizedDescription)
            return .failure(.saveError)
        }
    }
    
    func deleteBill(bill: Bill) -> Result<Void, CoreDataSaveError> {
        guard let cdBills = fetchBill(with: NSPredicate(format: "creationDate == %@", bill.creationDate as NSDate)), cdBills.count > 0 else { return .failure(.notGetAllData) }
        let cdBill = cdBills[0]
        guard let cdInvoice = cdBill.invoice else { return .failure(.notGetAllData)}
        makeUpdateInvoiceByDeletingBill(cdInvoice: cdInvoice, cdBill: cdBill)
        context.delete(cdBill)
        
        do {
            try context.save()
            return .success(())
        } catch {
            print(error.localizedDescription)
            return .failure(.saveError)
        }
    }
}
