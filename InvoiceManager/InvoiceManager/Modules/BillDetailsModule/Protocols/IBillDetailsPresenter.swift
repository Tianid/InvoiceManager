//
//  IBillDetailsPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 08.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol IBillDetailsPresenter: class {
    var billDetailsCreationState: BillDetailsCreationState { get set }
    var model: CDBill? { get set }
    func categoryFieldTapped(transition: PanelTransition)
    func categorySelectedWithData(category: CDCategory)
    func saveButtonTapped(name: String, value: Double, billState: BillState, description: String?)
    func deleteTapped()
}
