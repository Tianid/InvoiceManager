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
    var invoice: Invoice
    var model: [Bill]
    
    weak var superPresenter: IHomePresenter?
    
    init(invoice: Invoice, superPresenter: IHomePresenter) {
        self.invoice = invoice
        self.model = invoice.bills
        self.superPresenter = superPresenter
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
