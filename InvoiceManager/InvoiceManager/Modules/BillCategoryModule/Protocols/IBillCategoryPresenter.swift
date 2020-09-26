//
//  IBillCategoryPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 10.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol IBillCategoryPresenter {
    var model: [CDCategory] { get set }
    func categorySelected(index: Int)
    func dismissCategory()
}
