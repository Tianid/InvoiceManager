//
//  SettingsView.swift
//  InvoiceManager
//
//  Created by Tianid on 16.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    //MARK: - Properties
    var presenter: ISettingsPresenter?
    private let tableViewIdentifier = "tableViewIdentifier"
    private var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        table.backgroundColor = .clear
        table.tableFooterView = UIView()
        table.isScrollEnabled = false
        return table
    }()
    
    //MARK: - Init
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureViewsConstraint()
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Func
    
    private func configureViewsConstraint() {
        addSubview(tableView)
        
        tableView.anchor(top: safeAreaLayoutGuide.topAnchor,
                         leading: safeAreaLayoutGuide.leadingAnchor,
                         bottom: safeAreaLayoutGuide.bottomAnchor,
                         trailing: safeAreaLayoutGuide.trailingAnchor)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewIdentifier)
    }


}

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectedItemAt(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier, for: indexPath)
        guard let preparedCell = presenter?.prepareTableViewCell(cell: cell, indexPath: indexPath) else { return cell }
        return preparedCell
    }
    
    
}
