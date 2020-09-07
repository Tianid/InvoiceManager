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
    
    //MARK: - Init
    init(view: IHomeVC, router: IRouter, model: InvoiceContainer) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    //MARK: - Func
}

extension HomePresenter: IHomePresenter {
    func addNewBill() {
        var bills = model.invoices[2].bills
        let oldInvoice = model.invoices[2]
        
        bills.append(Bill(value: 993123, currency: .RUB, billName: "Added bill", billDescription: "", category: testSingleCategory, modifiedDate: Date()))
        
        let invoice = Invoice(name: oldInvoice.name,
                              balance: oldInvoice.balance,
                              bills: bills,
                              income: oldInvoice.income,
                              expense: oldInvoice.expense,
                              currency: oldInvoice.currency)
        
        model.invoices[2] = invoice
        view?.reloadCollectioView()
    }
    
    func generateSPHomeView() -> ISPHomeView {
        let presener = SPHomeView(superPresenter: self, model: model)
        return presener
    }
}
