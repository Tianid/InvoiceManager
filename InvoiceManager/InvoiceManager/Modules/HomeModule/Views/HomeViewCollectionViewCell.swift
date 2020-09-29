//
//  HomeViewCollectionViewCell.swift
//  InvoiceManager
//
//  Created by Tianid on 02.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import CoreData

class HomeViewCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    var context: NSManagedObjectContext?
    
    var presenter: IPHomeCollectionViewCell? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var fetchedResultsController: NSFetchedResultsController<CDBill>?
    
    private let tableIdentifier = "tableViewCell"
    private var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureConstraints()
        configureTableVIew()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    
    func deleteRowInTableView(billIndex: Int) {
        presenter?.reloadBills()
        tableView.deleteRows(at: [IndexPath(row: billIndex, section: 0)], with: .automatic)
    }
    
    func refreshTableViewByBillIndex(billIndex: Int) {
        presenter?.reloadBills()
        tableView.reloadRows(at: [IndexPath(row: billIndex, section: 0)], with: .automatic)
    }
    
    private func configureConstraints() {
        contentView.addSubview(tableView)
        
        tableView.anchor(top: safeAreaLayoutGuide.topAnchor,
                         leading: safeAreaLayoutGuide.leadingAnchor,
                         bottom: safeAreaLayoutGuide.bottomAnchor,
                         trailing: safeAreaLayoutGuide.trailingAnchor,
                         padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
    }
    
    private func configureTableVIew() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "\(HomeViewTableViewCell.self)", bundle: nil ), forCellReuseIdentifier: tableIdentifier)
        tableView.backgroundColor = .clear
    }
}

//MARK: - UITableViewDataSource
extension HomeViewCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        return presenter.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) as? HomeViewTableViewCell
        guard let forcCell = cell else { return UITableViewCell()}
        return presenter?.prepareTableViewCell(cell: forcCell, index: indexPath.row) ?? UITableViewCell()
    }
}
//MARK: - UITableViewDelegate
extension HomeViewCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         guard let count = presenter?.model.count else { return }
        presenter?.billTapped(billIndex: count - 1 - indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension HomeViewCollectionViewCell: IHomeViewCollectionViewCell {
    func insertNewRow() {
        presenter?.reloadBills()
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
}
