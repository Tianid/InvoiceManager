//
//  HomePresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class HomePresenter {
    //MARK: - Properties
    //    var model: InvoiceContainer
    var model: [CDInvoice]
    private(set) var currentInvoice: CDInvoice?
    private weak var view: IHomeVC?
    private var router: IRouter
    private var billInvoiceIndex = 0
    private var transefBillIndex = -1
    
    //MARK: - Init
    //    init(view: IHomeVC, router: IRouter, model: InvoiceContainer) {
    //        self.view = view
    //        self.router = router
    //        self.model = model
    //    }
    
    init(view: IHomeVC, router: IRouter, model: [CDInvoice]) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    //MARK: - Func
}

extension HomePresenter: IHomePresenter {
    func showBillDetail(invoice: CDInvoice, bill: CDBill?) {
        currentInvoice = invoice
        let modelCurrency = Currency(rawValue: currentInvoice!.currency!)!
        router.showBillDetailModule(superPresenter: self, model: bill, currency: modelCurrency)
        
    }
    
    func addNewInvoice(data: (String, Currency, String?)) {
        //        model.invoices.append(Invoice(data: data))
        view?.insertNewInvoice()
    }
    
    func showNewInvoice() {
        router.showNewInvoiceModule(superPresenter: self)
    }
    
    func presentAlert(alert: UIAlertController) {
        view?.showViewController(view: alert)
    }
    
    func setInvoiceIndex(invoiceIndex: Int) {
        self.billInvoiceIndex = invoiceIndex
    }
    
    func insertNewDataIntoUI(billDetailsCreationState: BillDetailsCreationState) {
        if billDetailsCreationState == .editing {
        } else if billDetailsCreationState == .creating {
            view?.insertNewData(index: billInvoiceIndex)
        }
    }
    
    
    func transferNewBill(bill: Bill, billDetailsCreationState: BillDetailsCreationState) {
        guard billInvoiceIndex != -1 else { return }
        
        
        if billDetailsCreationState == .editing {
            //            model.invoices[billInvoiceIndex].setupNewData(index: transefBillIndex, newValue: bill)
            view?.refreshTableViewRow(invoiceIndex: billInvoiceIndex, billIndex: transefBillIndex)
            
        } else if billDetailsCreationState == .creating {
            //            model.invoices[billInvoiceIndex].setupNewData(newValue: bill)
            view?.insertNewData(index: billInvoiceIndex)
        }
    }
    
    //    func showBillDetail(index: Int) {
    //        let invoice = model[billInvoiceIndex]
    //        let modelCurrency = Currency(rawValue: invoice.currency!)!
    //        router.showBillDetailModule(superPresenter: self, model: <#T##Bill?#>, currency: modelCurrency)
    //    }
    
    func showBillDetail(bill: Bill?, billIndex: Int?) {
        transefBillIndex = billIndex ?? -1
        //        let currency = model.invoices[billInvoiceIndex].currency
        //        router.showBillDetailModule(superPresenter: self, model: bill, currency: currency)
        
        //        guard let v = router.initBillDetailModule(superPresenter: self, model: bill, currency: currency) else { return }
        //        view?.showBillDetail(view: v)
    }
    
    
    func generateSPHomeView(invoice: CDInvoice) -> ISPHomeView {
        let presener = SPHomeView(superPresenter: self, model: invoice)
        return presener
    }
    
    //    func showEditBillDetail(bill: Bill, invoiceIndex: Int) {
    //        let currency = model.invoices[invoiceIndex].currency
    //        guard let detail = router.initBillDetailModule(superPresenter: self, model: bill, currency: currency) else { return }
    //        view?.showBillDetail(view: detail)
    //    }
    
    func deleteBillInModel(bill: Bill) {
        //        let index = model.invoices[billInvoiceIndex].bills.firstIndex { (model) -> Bool in
        //            model == bill
        //        }
        //
        //        guard let billIndex = index else { return }
        //        model.invoices[billInvoiceIndex].deleteDataByIndex(index: billIndex)
        //        view?.deleteRowInTableView(invoiceIndex: billInvoiceIndex, billIndex: billIndex)
    }
    
    func generateCellPresenter(invoice: CDInvoice) -> IPHomeCollectionViewCell {
        let presenter = PHomeCollectionViewCell(invoice: invoice)
        return presenter
    }
}
