//
//  IBillCategoryPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 10.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

protocol IBillCategoryPresenter: ICategoryPresenter {
    func categorySelected(indexPath: IndexPath)
    func dismissCategory()
}
