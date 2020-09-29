//
//  IHomePresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

protocol IHomePresenter: class {
    var model: [Invoice] { get set }
    var currentInvoice: Invoice? { get set }

    func generateCellPresenter(invoice: Invoice) -> IPHomeCollectionViewCell

    func showBillDetail(billIndex: Int?)
    func showNewInvoice()
    func presentAlert(alert: UIAlertController)
    func presentBillIntoUI(bill: Bill, billDetailsCreationState: BillDetailsCreationState)
    func addNewInvoice(invoice: Invoice)
    func updateInvoiceName(name: String, complition: (() -> ())?)
    
    func setInvoiceIndex(invoiceIndex: Int)
    
    func deleteBillInModel(bill: Bill)
    func deleteInvoice(complition: (() -> ())?)
}

protocol IPHomeCollectionViewCell {
    var invoice: Invoice { get }
    var model: [Bill] { get set }
    
    func reloadBills()
    func billTapped(billIndex: Int)
    func prepareTableViewCell(cell: HomeViewTableViewCell, index: Int) -> HomeViewTableViewCell
}
