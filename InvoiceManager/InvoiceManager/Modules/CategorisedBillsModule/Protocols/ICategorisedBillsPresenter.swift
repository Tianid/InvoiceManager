//
//  ICategorisedBillsPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 01.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

protocol ICategorisedBillsPresenter {
    var model: [Invoice] { get set }
    func prepareTableViewCell(cell: HomeViewTableViewCell, indexPath: IndexPath) -> UITableViewCell
    func billTapped(indexPath: IndexPath)
}
