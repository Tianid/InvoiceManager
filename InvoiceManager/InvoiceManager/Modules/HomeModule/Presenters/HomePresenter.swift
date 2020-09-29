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
    private var coreDataManage: ICoreDataManager
    
    //MARK: - Init
    
    init(view: IHomeVC, router: IRouter, model: InvoiceContainer, coreDataManager: ICoreDataManager) {
        self.view = view
        self.router = router
        self.invoiceContainer = model
        self.coreDataManage = coreDataManager
    }
    
    //MARK: - Func
}

extension HomePresenter: IHomePresenter {
    func generateCellPresenter(invoice: Invoice) -> IPHomeCollectionViewCell {
        let presenter = PHomeCollectionViewCell(invoice: invoice, superPresenter: self)
        return presenter
    }
    
    func showBillDetail(billIndex: Int?) {
        if billIndex == nil {
            router.showBillDetailModule(superPresenter: self, model: nil )
        } else {
            self.billIndex = billIndex!
            router.showBillDetailModule(superPresenter: self, model: model[invoiceIndex].bills[billIndex!] )
        }
    }
    
    func showNewInvoice() {
        router.showNewInvoiceModule(superPresenter: self)
    }
    
    func presentAlert(alert: UIAlertController) {
        view?.showViewController(view: alert)
    }
    
    func presentBillIntoUI(bill: Bill, billDetailsCreationState: BillDetailsCreationState) {
        guard invoiceIndex != -1 else { return }
        
        
        if billDetailsCreationState == .editing {
            currentInvoice?.setupNewData(index: billIndex, newValue: bill)
            view?.refreshTableViewRow(invoiceIndex: invoiceIndex, billIndex: billIndex)
            
        } else if billDetailsCreationState == .creating {
            currentInvoice?.setupNewData(newValue: bill)
            view?.insertNewData(index: invoiceIndex)
        }
    }
    
    func addNewInvoice(invoice: Invoice) {
        model.append(invoice)
        view?.insertNewInvoice()
    }
    
    func updateInvoiceName(name: String, complition: (() -> ())?) {
        currentInvoice?.name = name
        guard let invoice = currentInvoice else { return }
        let result = coreDataManage.updateInvoice(invoice: invoice)
        
        switch result {
        case .success(_):
            complition?()
        case .failure(_):
            break
        }
    }
    
    func setInvoiceIndex(invoiceIndex: Int) {
        self.invoiceIndex = invoiceIndex
    }
    
    func deleteBillInModel(bill: Bill) {
        guard let _ = currentInvoice else { return }
        let result = coreDataManage.deleteBill(bill: bill)
        
        switch result {
        case .success(_):
            currentInvoice?.deleteDataByIndex(index: billIndex)
            view?.deleteRowInTableView(invoiceIndex: invoiceIndex, billIndex: billIndex)
        case .failure(_):
            break
        }
    }
    
    func deleteInvoice(complition: (() -> ())?) {
        guard let invoice = currentInvoice else { return }
        let result = coreDataManage.deleteInvoice(invoice: invoice)
        
        switch result {
        case .success(_):
            model.remove(at: invoiceIndex)
            complition?()
        case .failure(_):
            break
        }
    }
}
