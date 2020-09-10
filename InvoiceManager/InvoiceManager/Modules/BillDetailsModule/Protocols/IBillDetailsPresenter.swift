//
//  IBillDetailsPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 08.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol IBillDetailsPresenter: class {
    func categoryFieldTapped(transition: PanelTransition)
    func categorySelectedWithData(category: Category)
    func saveButtonTapped(name: String, value: Double, billState: BillState, description: String?)
}
