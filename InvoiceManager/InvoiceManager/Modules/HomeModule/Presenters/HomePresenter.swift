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
    private var billInvoiceIndex = -1
    
    //MARK: - Init
    init(view: IHomeVC, router: IRouter, model: InvoiceContainer) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    //MARK: - Func
}

extension HomePresenter: IHomePresenter {

    
    func transferNewBill(bill: Bill) {
        guard billInvoiceIndex != -1 else { return }
        model.invoices[billInvoiceIndex].bills.append(bill)
        view?.insertNewData(index: billInvoiceIndex)
        
    }
    
    func showBillDetail(index: Int) {
        billInvoiceIndex = index
        let currency = model.invoices[index].currency
        guard let v = router.initBillDetailModule(superPresenter: self, model: nil, currency: currency) else { return }
        view?.showBillDetail(view: v)
    }
    
    
    func generateSPHomeView(view: IHomeView) -> ISPHomeView {
        let presener = SPHomeView(superPresenter: self, model: model, view: view)
        return presener
    }
}
