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
    func prepareTableViewCell(cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell
}
