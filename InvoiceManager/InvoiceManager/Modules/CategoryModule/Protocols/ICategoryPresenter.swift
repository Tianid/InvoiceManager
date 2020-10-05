//
//  ICategoryPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

protocol ICategoryPresenter: class {
    var model: [SuperSection] { get set }
}

protocol ICategoryTableContainer: ICategoryPresenter {
    var filteredModels: [Category] { get set }
    func prepareTableViewCell(cell: CategoryTableViewCell, indexPath: IndexPath, isFiltering: Bool) -> UITableViewCell
    func billTapped(indexPath: IndexPath, isFiltering: Bool)
    func filter(searchText: String)
}
