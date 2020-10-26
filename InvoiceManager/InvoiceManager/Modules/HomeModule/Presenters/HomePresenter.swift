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
    private var coreDataManager: ICoreDataManager
    
    //MARK: - Init
    
    init(view: IHomeVC, router: IRouter, model: InvoiceContainer, coreDataManager: ICoreDataManager) {
        self.view = view
        self.router = router
        self.invoiceContainer = model
        self.coreDataManager = coreDataManager
    }
    
    //MARK: - Func
}

extension HomePresenter: IHomePresenter {
    func setUserInfo(userInfo: [AnyHashable : Any], complition: (() -> ())?) {
        let model = userInfo["IMData"] as? [Invoice]
        self.model = model ?? []
        complition?()
    }
    
    func generateCellPresenter(invoice: Invoice) -> IPHomeCollectionViewCell {
        let presenter = PHomeCollectionViewCell(invoice: invoice, superPresenter: self)
        return presenter
    }
    
    func showBillDetail(billIndex: Int?) {
        if billIndex == nil {
            router.showBillDetailModule(superPresenter: self, model: nil, billDetailsPresentingType: .edit)
        } else {
            self.billIndex = billIndex!
            router.showBillDetailModule(superPresenter: self, model: model[invoiceIndex].bills[billIndex!], billDetailsPresentingType: .edit)
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
            let count = (currentInvoice?.bills.count)! - 1
            currentInvoice?.setupNewData(index: billIndex, newValue: bill)
            view?.refreshTableViewRow(invoiceIndex: invoiceIndex, billIndex: count - billIndex)
            
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
        let result = coreDataManager.updateInvoice(invoice: invoice)
        
        switch result {
        case .success(_):
            NotificationCenter.default.post(name: .modelsDidChanged, object: nil)
            complition?()
        case .failure(_):
            break
        }
    }
    
    func setInvoiceIndex(invoiceIndex: Int) {
        self.invoiceIndex = invoiceIndex
    }
    
    func deleteBillInModel(bill: Bill, indexPath: IndexPath) {
        guard let _ = currentInvoice else { return }
        let result = coreDataManager.deleteBill(bill: bill)
        
        switch result {
        case .success(_):
            NotificationCenter.default.post(name: .modelsDidChanged, object: nil)
            let count = (currentInvoice?.bills.count)! - 1
            currentInvoice?.deleteDataByIndex(index: indexPath.row)
            view?.deleteRowInTableView(invoiceIndex: invoiceIndex, billIndex: count - indexPath.row)
        case .failure(_):
            break
        }
    }
    
    func deleteInvoice(complition: (() -> ())?) {
        guard let invoice = currentInvoice else { return }
        let result = coreDataManager.deleteInvoice(invoice: invoice)
        
        switch result {
        case .success(_):
            NotificationCenter.default.post(name: .modelsDidChanged, object: nil)
            model.remove(at: invoiceIndex)
            complition?()
        case .failure(_):
            break
        }
    }
}
