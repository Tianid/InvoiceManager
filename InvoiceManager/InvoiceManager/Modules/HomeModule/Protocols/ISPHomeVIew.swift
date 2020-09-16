//
//  ISPHomeVIew.swift
//  InvoiceManager
//
//  Created by Tianid on 07.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

protocol ISPHomeView: class {
    var model: InvoiceContainer { get set }
    var superPresenter: IHomePresenter? { get set }
    func generateSPHomeViewCell(index: Int) -> ISPHomeViewCell
    func showBillDetail(bill: Bill?, billIndex: Int?)
    func setInvoiceIndex(invoiceIndex: Int)
    func presentAlert(alert: UIAlertController)
    func setNewName(name: String, invoiceIndex: Int, complition: (() -> ())?)
    func deleteInvoice(invoiceIndex: Int, complition: (() -> ())?)
    func newInvoiceButtonTapped()
}
