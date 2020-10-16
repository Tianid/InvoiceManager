//
//  ISettingsPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

protocol ISettingsPresenter {
    var model: [Settings] { get set }
    func prepareTableViewCell(cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell
    func selectedItemAt(indexPath: IndexPath)
    func cryptedItemSelected(data: Data)
}
