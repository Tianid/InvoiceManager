//
//  CategoryPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit
import Foundation

class CategoryPresenter {
    //MARK: - Properties
    var model: [SuperSection]
    var filteredModels: [(Int, [Int])] = []
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
        
        let result = model.enumerated().compactMap { (section) -> (Int, [Int])? in
            let filtered = section.element.categorys.enumerated().filter {
                return $0.element.name.lowercased().contains(searchText.lowercased())
            }.map { $0.offset }
            return filtered.count < 1 ? nil : (section.offset, filtered)
        }
        
        //MARK: - another version
        //                var categorys: [Category] = []
        //                model.forEach { (superSection) in
        //                    categorys += superSection.categorys.filter { (category) -> Bool in
        //                        return category.name.lowercased().contains(searchText.lowercased())
        //                    }
        //                }
        //         filteredModels = categorys
        filteredModels = result
    }
    
    func prepareTableViewCell(cell: CategoryTableViewCell, indexPath: IndexPath, isFiltering: Bool) -> UITableViewCell {
        if isFiltering {
            let indexRow = filteredModels[indexPath.section].1[indexPath.row]
            let indexSection = filteredModels[indexPath.section].0
            cell.categoryLabel.text = model[indexSection].categorys[indexRow].name
        } else {
            cell.categoryLabel.text = model[indexPath.section].categorys[indexPath.row].name
        }
        return cell
    }
    
    func billTapped(indexPath: IndexPath, isFiltering: Bool) {
        if isFiltering {
            let indexRow = filteredModels[indexPath.section].1[indexPath.row]
            let indexSection = filteredModels[indexPath.section].0
            let category = model[indexSection].categorys[indexRow]
            router.showCategorisedBillsModule(category: category)
        } else {
            router.showCategorisedBillsModule(category: model[indexPath.section].categorys[indexPath.row])
        }
    }
    
    func getSectionNameForFilterdSections(section: Int) -> String {
        let indexSection = filteredModels[section].0
        return model[indexSection].section.name
    }
}
