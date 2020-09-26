//
//  SPHomeView.swift
//  InvoiceManager
//
//  Created by Tianid on 07.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

class SPHomeView {
    //MARK: - Properties
    var model: CDInvoice
    weak var superPresenter: IHomePresenter?
    
    //MARK: - Init
    init(superPresenter: IHomePresenter, model: CDInvoice) {
        self.superPresenter = superPresenter
        self.model = model
    }
    
    //MARK: - Func
    
}

extension SPHomeView: ISPHomeView {
    func newInvoiceButtonTapped() {
        superPresenter?.showNewInvoice()
    }
    
    func deleteInvoice(invoiceIndex: Int, complition: (() -> ())?) {
//        model.invoices.remove(at: invoiceIndex)
//        complition?()
    }
    
    func setNewName(name: String, invoiceIndex: Int, complition: (() -> ())?) {
//        let invoice = model.invoices[invoiceIndex]
//        
//        model.invoices[invoiceIndex] = Invoice(name: name,
//                                               balance: invoice.balance,
//                                               bills: invoice.bills,
//                                               income: invoice.income,
//                                               expense: invoice.expense,
//                                               currency: invoice.currency)
//        complition?()
    }
    
    func presentAlert(alert: UIAlertController) {
        superPresenter?.presentAlert(alert: alert)
    }
    
    func setInvoiceIndex(invoiceIndex: Int) {
        superPresenter?.setInvoiceIndex(invoiceIndex: invoiceIndex)
    }
    
    func showBillDetail(bill: Bill?, billIndex: Int?) {
        superPresenter?.showBillDetail(bill: bill, billIndex: billIndex)
    }
    
    func generateSPHomeViewCell(index: Int) -> ISPHomeViewCell {
        let presenter = SPHomeViewCell(superPresenter: self, invoiceIndex: index)
        return presenter
    }
    
    //    func showBillDetail(bill: Bill?, index: Int) {
    //        superPresenter?.showBillDetail(index: index)
    //
    //
    ////        let bill = Bill(value: 993123, currency: .RUB, billName: "Added bill", billDescription: "", category: testSingleCategory, modifiedDate: Date())
    ////        model.invoices[index].bills.append(bill)
    ////        view?.insertNewBill(index: index)
    //
    //    }
    
}
