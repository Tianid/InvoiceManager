//
//  CategorisedBillsView.swift
//  InvoiceManager
//
//  Created by Tianid on 01.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class CategorisedBillsView: UIView {
    //MARK: - Properties
    var presenter: ICategorisedBillsPresenter?
    
    private let tableIdentifierCell = "tableIdentifierCell"
    private var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)) {
        super.init(frame: frame)
        configureConstraints()
        configureTableView()
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
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "\(HomeViewTableViewCell.self)", bundle: nil), forCellReuseIdentifier: tableIdentifierCell)
    }
}

extension CategorisedBillsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.billTapped(indexPath: indexPath)
    }
}

extension CategorisedBillsView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.model.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.model[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model[section].bills.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifierCell, for: indexPath) as? HomeViewTableViewCell else { return UITableViewCell() }
        guard let preparedCell = presenter?.prepareTableViewCell(cell: cell, indexPath: indexPath) else { return UITableViewCell() }
        return preparedCell
    }
}
