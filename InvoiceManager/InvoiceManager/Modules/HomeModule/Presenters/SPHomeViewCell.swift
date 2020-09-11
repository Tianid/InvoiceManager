//
//  SPHomeViewCell.swift
//  InvoiceManager
//
//  Created by Tianid on 07.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class SPHomeViewCell {
    
    //MARK: - Properties
    var model: [Bill]? {
        get {
            superPresenter?.model.invoices[invoiceIndex].bills
        }
        set {
            superPresenter?.model.invoices[invoiceIndex].bills = newValue!
        }
    }
    weak var superPresenter: ISPHomeView?
    private var invoiceIndex: Int
    
    //MARK: - Init
    init(superPresenter: ISPHomeView, invoiceIndex: Int) {
        self.superPresenter = superPresenter
        self.invoiceIndex = invoiceIndex
    }
    
    //MARK: - Func
}

extension SPHomeViewCell: ISPHomeViewCell {
    func setInvoiceInex(invoiceIndex: Int) {
        superPresenter?.setInvoiceIndex(invoiceIndex: invoiceIndex)
    }

    func billTapped(billIndex: Int) {
        guard let bill = model?[billIndex] else { return }
        superPresenter?.showBillDetail(bill: bill, billIndex: billIndex)
    }
}
