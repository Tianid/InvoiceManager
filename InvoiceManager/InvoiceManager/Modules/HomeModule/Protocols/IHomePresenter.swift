//
//  IHomePresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol IHomePresenter: class {
    var model: InvoiceContainer { get set }
    func generateSPHomeView() -> ISPHomeView
    func addNewBill()
}
