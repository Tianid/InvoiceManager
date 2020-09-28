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
    var model: [Invoice] {
        get {
            return invoiceContainer.invoices
        }
        
        set {
            invoiceContainer.invoices = newValue
        }
    }
    
    var currentInvoice: Invoice? {
        get {
            model[invoiceIndex]
        }
        
        set {
            guard let value = newValue else { return }
            model[invoiceIndex] = value
        }
    }
    private var invoiceContainer: InvoiceContainer
    private weak var view: IHomeVC?
    private var router: IRouter
    private var invoiceIndex = 0
    private var billIndex = -1
    
    //MARK: - Init
    
    init(view: IHomeVC, router: IRouter, model: InvoiceContainer) {
        self.view = view
        self.router = router
        self.invoiceContainer = model
    }
    
    //MARK: - Func
}

extension HomePresenter: IHomePresenter {
    
    func showBillDetail(billIndex: Int?) {
        if billIndex == nil {
            router.showBillDetailModule(superPresenter: self, model: nil )
        } else {
            self.billIndex = billIndex!
            router.showBillDetailModule(superPresenter: self, model: model[invoiceIndex].bills[billIndex!] )
        }
        
    }
    
    func addNewInvoice(invoice: Invoice) {
        model.append(invoice)
        view?.insertNewInvoice()
    }
    
    func showNewInvoice() {
        router.showNewInvoiceModule(superPresenter: self)
    }
    
    func presentAlert(alert: UIAlertController) {
        view?.showViewController(view: alert)
    }
    
    func setInvoiceIndex(invoiceIndex: Int) {
        self.invoiceIndex = invoiceIndex
    }
    
//    func insertNewDataIntoUI(billDetailsCreationState: BillDetailsCreationState) {
//        if billDetailsCreationState == .editing {
//        } else if billDetailsCreationState == .creating {
//            view?.insertNewData(index: invoiceIndex)
//        }
//    }
    
    func presentBillInotUI(bill: Bill, billDetailsCreationState: BillDetailsCreationState) {
        guard invoiceIndex != -1 else { return }
        
        
        if billDetailsCreationState == .editing {
            currentInvoice?.setupNewData(index: billIndex, newValue: bill)
            view?.refreshTableViewRow(invoiceIndex: invoiceIndex, billIndex: billIndex)
            
        } else if billDetailsCreationState == .creating {
            currentInvoice?.setupNewData(newValue: bill)
            view?.insertNewData(index: invoiceIndex)
        }
    }
    
    func deleteBillInModel(bill: Bill) {
        //        let index = model.invoices[billInvoiceIndex].bills.firstIndex { (model) -> Bool in
        //            model == bill
        //        }
        //
        //        guard let billIndex = index else { return }
        //        model.invoices[billInvoiceIndex].deleteDataByIndex(index: billIndex)
        //        view?.deleteRowInTableView(invoiceIndex: billInvoiceIndex, billIndex: billIndex)
    }
    
    func generateCellPresenter(invoice: Invoice) -> IPHomeCollectionViewCell {
        let presenter = PHomeCollectionViewCell(invoice: invoice, superPresenter: self)
        return presenter
    }
}
