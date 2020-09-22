//
//  INewInvoicePresenter.swift.swift
//  InvoiceManager
//
//  Created by Tianid on 16.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol INewInvoicePresenter {
    func saveNewInvoice(data: (String, Currency, String?))
}
