//
//  HomePresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class HomePresenter {
    //MARK: - Properties
    var model: InvoiceContainer
    private weak var view: IHomeVC?
    private var router: IRouter
    private var billInvoiceIndex = 0
    private var transefBillIndex = -1
    
    //MARK: - Init
    init(view: IHomeVC, router: IRouter, model: InvoiceContainer) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    //MARK: - Func
}

extension HomePresenter: IHomePresenter {
    func setInvoiceInex(invoiceIndex: Int) {
        self.billInvoiceIndex = invoiceIndex
    }
    
    func transferNewBill(bill: Bill, billDetailsCreationState: BillDetailsCreationState) {
        guard billInvoiceIndex != -1 else { return }
        
        
        if billDetailsCreationState == .editing {
            model.invoices[billInvoiceIndex].bills[transefBillIndex] = bill
            view?.refreshTableViewRow(invoiceIndex: billInvoiceIndex, billIndex: transefBillIndex)
            
        } else if billDetailsCreationState == .creating {
            model.invoices[billInvoiceIndex].bills.append(bill)
            view?.insertNewData(index: billInvoiceIndex)
        }
    }
    
    func showBillDetail(bill: Bill?, billIndex: Int?) {
        transefBillIndex = billIndex ?? -1
        let currency = model.invoices[billInvoiceIndex].currency
        
        router.showBillDetailModule(superPresenter: self, model: bill, currency: currency)
        
//        guard let v = router.initBillDetailModule(superPresenter: self, model: bill, currency: currency) else { return }
//        view?.showBillDetail(view: v)
    }
    
    
    func generateSPHomeView(view: IHomeView) -> ISPHomeView {
        let presener = SPHomeView(superPresenter: self, model: model, view: view)
        return presener
    }
    
    //    func showEditBillDetail(bill: Bill, invoiceIndex: Int) {
    //        let currency = model.invoices[invoiceIndex].currency
    //        guard let detail = router.initBillDetailModule(superPresenter: self, model: bill, currency: currency) else { return }
    //        view?.showBillDetail(view: detail)
    //    }
    
    func deleteBillInModel(bill: Bill) {
        let index = model.invoices[billInvoiceIndex].bills.firstIndex { (model) -> Bool in
            model == bill
        }
        
        guard let billIndex = index else { return }
        model.invoices[billInvoiceIndex].bills.removeAll { $0 == bill }
        view?.deleteRowInTableView(invoiceIndex: billInvoiceIndex, billIndex: billIndex)
    }
}
