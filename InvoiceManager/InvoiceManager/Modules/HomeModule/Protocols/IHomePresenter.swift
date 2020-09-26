//
//  IHomePresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

protocol IHomePresenter: class {
//    var model: InvoiceContainer { get set }
    var model: [CDInvoice] { get set }
    var currentInvoice: CDInvoice? { get }

    func generateCellPresenter(invoice: CDInvoice) -> IPHomeCollectionViewCell

    func showBillDetail(bill: Bill?, billIndex: Int?)
    func showBillDetail(invoice: CDInvoice, bill: CDBill?)
    
    func insertNewDataIntoUI(billDetailsCreationState: BillDetailsCreationState)
    
    func transferNewBill(bill: Bill, billDetailsCreationState: BillDetailsCreationState)
    func setInvoiceIndex(invoiceIndex: Int)
    func deleteBillInModel(bill: Bill)
    func presentAlert(alert: UIAlertController)
    func showNewInvoice()
    func addNewInvoice(data: (String, Currency, String?))
}

protocol IPHomeCollectionViewCell {
    var invoice: CDInvoice { get }
    var model: [CDBill] { get set }
    
    func reloadBills() 
}
