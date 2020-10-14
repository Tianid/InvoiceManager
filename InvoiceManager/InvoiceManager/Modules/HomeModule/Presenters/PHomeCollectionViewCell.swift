//
//  PHomeCollectionViewCell.swift
//  InvoiceManager
//
//  Created by Tianid on 25.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import UIKit


class PHomeCollectionViewCell {
    //MARK: Properties
    var invoice: Invoice
    var model: [Bill]
    
    weak var superPresenter: IHomePresenter?
    
    //MARK: Init
    init(invoice: Invoice, superPresenter: IHomePresenter) {
        self.invoice = invoice
        self.model = invoice.bills
        self.superPresenter = superPresenter
    }
    
    //MARK: Func
    private func showDeleteAlert(indexPath: IndexPath) {
        guard indexPath.row <= model.count - 1 else { return }
        let index = model.count - 1 - indexPath.row
        let newIndexPath = IndexPath(row: index, section: indexPath.section)
        let bill = model[newIndexPath.row]
        let alert = UIAlertController(title: nil, message: "You definitely want to delete this bill?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] (_) in
            self?.superPresenter?.deleteBillInModel(bill: bill, indexPath: newIndexPath)
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in }
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.superPresenter?.presentAlert(alert: alert)
    }
}


extension PHomeCollectionViewCell: IPHomeCollectionViewCell {
    func prepareTableViewCell(cell: HomeViewTableViewCell, index: Int) -> HomeViewTableViewCell {
        let count = model.count
        let bill = model[count - 1 - index]

        cell.billNameLabel.text = bill.billName
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy HH:mm"
        cell.billDateLabel.text = dateFormatter.string(from: bill.creationDate)
        cell.billCategoryLabel.text = bill.category.name
        cell.billValueLabel.text = String(bill.value).currencySetFormatting(currencySymbol: bill.currency.symbolRaw)
        cell.presenter = self
        return cell
    }
    
    func billTapped(billIndex: Int) {
        superPresenter?.showBillDetail(billIndex: billIndex)
    }
    
    func reloadBills() {
        guard let bills = superPresenter?.currentInvoice?.bills else { return }
        model = bills
    }
}

extension PHomeCollectionViewCell: IHomeViewTableViewCell {
    func deleteButtonTapped(indexPath: IndexPath) {
        showDeleteAlert(indexPath: indexPath)
    }
}
