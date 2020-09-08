//
//  SPHomeView.swift
//  InvoiceManager
//
//  Created by Tianid on 07.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import Foundation

class SPHomeView {
    //MARK: - Properties
    var model: InvoiceContainer
    weak var superPresenter: IHomePresenter?
    private weak var view: IHomeView?
    
    //MARK: - Init
    init(superPresenter: IHomePresenter, model: InvoiceContainer, view: IHomeView) {
        self.superPresenter = superPresenter
        self.model = model
        self.view = view
    }
    
    //MARK: - Func

}

extension SPHomeView: ISPHomeView {
    func generateSPHomeViewCell(index: Int) -> ISPHomeViewCell {
        let presenter = SPHomeViewCell(superPresenter: self, invoiceIndex: index)
        return presenter
    }
    
    func addNewBillButtonTapped(index: Int) {
        let bill = Bill(value: 993123, currency: .RUB, billName: "Added bill", billDescription: "", category: testSingleCategory, modifiedDate: Date())
        model.invoices[index].bills.append(bill)
        view?.insertNewBill(index: index)
        
    }
    
}
