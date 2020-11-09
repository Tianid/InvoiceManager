//
//  CategorisedBillsPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 01.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

class CategorisedBillsPresenter {
    //MARK: - Properties
    var model: [Invoice]
    private weak var view: ICategorisedBillsVC?
    private var router: IRouter
    //MARK: - Init
    
    init(view: ICategorisedBillsVC, router: IRouter, model: [Invoice]) {
        self.view = view
        self.router = router
        self.model = model
    }
    //MARK: - Func
    
    private func calculateBill(by indexPath: IndexPath) -> Bill {
        let rowCount = model[indexPath.section].bills.count - 1
        let bill = model[indexPath.section].bills[rowCount - indexPath.row]
        return bill
    }
}

extension CategorisedBillsPresenter: ICategorisedBillsPresenter {
    
    func prepareTableViewCell(cell: HomeViewTableViewCell, indexPath: IndexPath) -> UITableViewCell {

        let bill = calculateBill(by: indexPath)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy HH:mm"

        cell.billNameLabel.text = bill.billName
        cell.billCategoryLabel.text = bill.category.name
        cell.billDateLabel.text = dateFormatter.string(from: bill.creationDate)
        cell.billValueLabel.text = String(bill.value).currencySetFormatting(currencySymbol: bill.currency.symbolRaw)
        cell.iconImageView.image = UIImage(named: bill.category.name.lowercased())
        cell.iconImageView.backgroundColor = CategoryColors.colors[bill.category.name]
        cell.isReadOnly = true
        return cell
    }
    
    func billTapped(indexPath: IndexPath) {
        let bill = calculateBill(by: indexPath)
        router.showBillDetailModule(superPresenter: nil, model: bill, billDetailsPresentingType: .readOnly)
    }
    
}
