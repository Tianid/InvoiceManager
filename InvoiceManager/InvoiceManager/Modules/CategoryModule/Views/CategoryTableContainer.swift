//
//  CategoryTableContainer.swift
//  InvoiceManager
//
//  Created by Tianid on 30.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class CategoryTableContainer: UIView {
    //MARK: - Properties
    weak var presenter: ICategoryTableContainer?
    var navigationItem: UINavigationItem? {
        didSet {
            configureSearchController()
        }
    }
    
    private let categoryTableIdentifier = "categoryTableIdentifier"

    private var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.contentInsetAdjustmentBehavior = .never
        return table
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    //MARK: - Init
    override init(frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)) {
        super.init(frame: frame)
        configureConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    
    private func configureConstraints() {
        addSubview(tableView)
        tableView.anchor(top: safeAreaLayoutGuide.topAnchor,
                         leading: safeAreaLayoutGuide.leadingAnchor,
                         bottom: safeAreaLayoutGuide.bottomAnchor,
                         trailing: safeAreaLayoutGuide.trailingAnchor)
    }
    
    private func configureViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "\(CategoryTableViewCell.self)", bundle: nil), forCellReuseIdentifier: categoryTableIdentifier)
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem?.searchController = searchController
    }
}

extension CategoryTableContainer: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.billTapped(indexPath: indexPath, isFiltering: isFiltering)
    }
}

extension CategoryTableContainer: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return 1
        }
        return presenter?.model.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering {
            return ""
        }
        return presenter?.model[section].section.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return presenter?.filteredModels.count ?? 0
        }
        return presenter?.model[section].categorys.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: categoryTableIdentifier, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        guard let preparedCell = presenter?.prepareTableViewCell(cell: cell, indexPath: indexPath, isFiltering: isFiltering) else { return cell }
        return preparedCell
    }
}


extension CategoryTableContainer: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        presenter?.filter(searchText: searchText)
        tableView.reloadData()
    }
}
