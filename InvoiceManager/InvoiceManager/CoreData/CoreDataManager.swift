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
    
    func fetchAllInvoicesWithAllBills(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [Invoice]
    func fetchAllSectionsWitAllCategorys() -> [SuperSection]
    func fetchBillsWithInvoices(by category: Category) -> [Invoice]
    
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
                                           section: Section(name: (cdBill.category?.section?.name)!,
                                                            categoryCount: cdBill.category?.section?.category?.count ?? 0),
                                           creationDate: cdBill.category?.creationDate ?? Date()),
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
                                section: Section(name: (cdCategory.section?.name!)!,
                                                 categoryCount: cdCategory.section?.category?.count ?? 0),
                                creationDate: cdCategory.creationDate ?? Date())
        return category
    }
    
    private func transformCDSectionModelToAppSectionModel(cdSection: CDSection) -> Section {
        let section = Section(name: cdSection.name ?? "",
                              categoryCount: cdSection.category?.count ?? 0)
        return section
    }
    
    //MARK: - Transform App entitites to CD entities
    
    private func transformAppBillModelToCDBillModel(bill: Bill, updatableBill: CDBill? = nil) -> CDBill? {
        
        guard let category = fetchBy(entity: CDCategory.self, with: NSPredicate(format: "name == %@", "\(bill.category.name)")) else { return nil }
        
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
    
    private func fetchBy<T: NSManagedObject>(entity: T.Type, with predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "\(entity.self)")
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        do {
            let data = try context.fetch(request) as? [T]
            return data
        } catch {
            print(error)
            return nil
        }
    }
    
    //MARK: - Update entities
    
    private func makeUpdateInvoiceName(invoice: Invoice) {
        guard let cdInvoices = fetchBy(entity: CDInvoice.self, with: NSPredicate(format: "creationDate == %@", invoice.creationDate as NSDate)), cdInvoices.count > 0 else { return }
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
    
    //MARK: Grouping
    private func makeGroupingBillByInvoice(cdBills: [CDBill]) -> [Invoice] {
        var bills: [Bill] = []
        var result: [Invoice] = []
        
        
        for (index,cdBill) in cdBills.enumerated() {
            if index == 0 {
                let bill = transformCDBillModelToAppBillModel(cdBill: cdBill, cdCurrency: (cdBill.invoice?.currency)!)
                bills.append(bill)
                
            } else {
                if cdBills[index - 1].invoice?.name != cdBill.invoice?.name {
                    let inv = cdBills[index - 1].invoice
                    result.append(initInvoice(cdInvoice: inv, bills: bills))
                    bills = []
                }
                
                let bill = transformCDBillModelToAppBillModel(cdBill: cdBill, cdCurrency: (cdBill.invoice?.currency)!)
                bills.append(bill)
            }
            
            if index == cdBills.count - 1 {
                let inv = cdBills[index].invoice
                result.append(initInvoice(cdInvoice: inv, bills: bills))
            }
        }
        return result
    }
    
    private func initInvoice(cdInvoice: CDInvoice?, bills: [Bill]) -> Invoice {
        return Invoice(name: cdInvoice?.name ?? "",
                              balance: cdInvoice?.balance ?? 0,
                              bills: bills,
                              income: cdInvoice?.income ?? 0,
                              expense: cdInvoice?.expense ?? 0,
                              currency: Currency(rawValue: cdInvoice?.currency ?? "none") ?? Currency.none)
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
        guard let cdInvoices = fetchBy(entity: CDInvoice.self, with: NSPredicate(format: "creationDate == %@", invoice.creationDate as NSDate)), !cdInvoices.isEmpty else { return .failure(.notGetAllData)}
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
        guard let cdBills = fetchBy(entity: CDBill.self, with: NSPredicate(format: "creationDate == %@", bill.creationDate as NSDate)), cdBills.count > 0 else { return .failure(.notGetAllData)}
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
    func fetchAllInvoicesWithAllBills(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [Invoice] {
        let request = NSFetchRequest<CDInvoice>(entityName: "\(CDInvoice.self)")
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
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
    
    func fetchAllSectionsWitAllCategorys() -> [SuperSection] {
        let request = NSFetchRequest<CDSection>(entityName: "\(CDSection.self)")
        
        do {
            let cdSections = try context.fetch(request)
            var superSections: [SuperSection] = []
            
            
            for cdSection in cdSections {
                var categorys: [Category] = []
                let soredCDCategorys = cdSection.category?.sortedArray(using: [NSSortDescriptor(key: "name", ascending: true)]) as? [CDCategory]
                for cdCategory in soredCDCategorys! {
                    let category = transformCDCategoryModelToAppCategoryModel(cdCategory: cdCategory)
                    categorys.append(category)
                }
                
                let section = transformCDSectionModelToAppSectionModel(cdSection: cdSection)
                superSections.append(SuperSection(section: section,
                                                  categorys: categorys))
            }
            
            return superSections
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func fetchBillsWithInvoices(by category: Category) -> [Invoice] {
        guard let cdBills = fetchBy(entity: CDBill.self,
                                    with: NSPredicate(format: "category.creationDate == %@", category.creationDate as NSDate),
                                    sortDescriptors: [ NSSortDescriptor(key: "invoice.creationDate", ascending: true)]), cdBills.count > 0 else { return [] }
        
        let result = makeGroupingBillByInvoice(cdBills: cdBills)
        return result
    }
    
    
    //MARK: - Delete entitys
    func deleteInvoice(invoice: Invoice) -> Result<Void, CoreDataSaveError> {
        guard let cdInvoices = fetchBy(entity: CDInvoice.self, with: NSPredicate(format: "creationDate == %@", invoice.creationDate as NSDate)), cdInvoices.count > 0 else { return .failure(.notGetAllData)}
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
        guard let cdBills = fetchBy(entity: CDBill.self, with: NSPredicate(format: "creationDate == %@", bill.creationDate as NSDate)), cdBills.count > 0 else { return .failure(.notGetAllData) }
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
