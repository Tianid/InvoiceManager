//
//  CategoryPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

class CategoryPresenter {
    //MARK: - Properties
    var model: [SuperSection]
    private weak var view: ICategoryVC?
    private var router: IRouter
    private var indexOfCategorysInSections: [[Int]] = []

    
    //MARK: - Init
    init(view: ICategoryVC, router: IRouter, model: [SuperSection]) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    //MARK: - Func
}

extension CategoryPresenter: ICategoryTableContainer {
    func prepareTableViewCell(cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell {
        cell.textLabel?.text = model[indexPath.section].categorys[indexPath.row].name
        return cell
    }
}
