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
    var filteredModels: [Category] = []
    private weak var view: ICategoryVC?
    private var router: IRouter

    
    //MARK: - Init
    init(view: ICategoryVC, router: IRouter, model: [SuperSection]) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    //MARK: - Func
}

extension CategoryPresenter: ICategoryTableContainer {
    func filter(searchText: String) {
        var categorys: [Category] = []
        model.forEach { (superSection) in
            categorys += superSection.categorys.filter { (category) -> Bool in
                return category.name.lowercased().contains(searchText.lowercased())
            }
        }
        filteredModels = categorys
    }
    
    func prepareTableViewCell(cell: CategoryTableViewCell, indexPath: IndexPath, isFiltering: Bool) -> UITableViewCell {
        if isFiltering {
            cell.categoryLabel.text = filteredModels[indexPath.row].name
        } else {
            cell.categoryLabel.text = model[indexPath.section].categorys[indexPath.row].name
        }
        return cell
    }
    
    func billTapped(indexPath: IndexPath, isFiltering: Bool) {
        if isFiltering {
            router.showCategorisedBillsModule(category: filteredModels[indexPath.row])
        } else {
            router.showCategorisedBillsModule(category: model[indexPath.section].categorys[indexPath.row])
        }
    }
}
