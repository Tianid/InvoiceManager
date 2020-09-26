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
    var context: NSManagedObjectContext?  {
        didSet {
            if context != nil {
                setupFetchResultsController(for: context!)
                fetchData()
            }
        }
    }
    
    var presenter: IPHomeCollectionViewCell?
    
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
        tableView.deleteRows(at: [IndexPath(row: billIndex, section: 0)], with: .automatic)
    }
    
    func refreshTableViewByBillIndex(billIndex: Int) {
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
    
    private func fetchData() {
        try! fetchedResultsController?.performFetch()
        tableView.reloadData()
    }
    
    private func setupFetchResultsController(for context: NSManagedObjectContext) {
        let sortDescriptor = NSSortDescriptor(key: "modifiedDate", ascending: false)
        let request = NSFetchRequest<CDBill>(entityName: "\(CDBill.self)")
        request.predicate = NSPredicate(format: "invoice.name == %@", (presenter?.invoice.name)!)

        request.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        fetchedResultsController?.delegate = self
    }
}

//MARK: - UITableViewDataSource
extension HomeViewCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController?.sections else { return 0 }
        return sections[section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) as? HomeViewTableViewCell
//        guard let data = presenter?.model[indexPath.row] else { return UITableViewCell() }
        guard let bill = fetchedResultsController?.object(at: indexPath) else { return cell!}

        cell?.billNameLabel.text = bill.billName
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy HH:mm"
        cell?.billDateLabel.text = dateFormatter.string(from: bill.modifiedDate!)
        cell?.billCategoryLabel.text = bill.category?.name
        cell?.billValueLabel.text = String(bill.value)
//                cell.textLabel?.text = String(indexPath.row)
        return cell!
    }
}
//MARK: - UITableViewDelegate
extension HomeViewCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter?.billTapped(billIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension HomeViewCollectionViewCell: IHomeViewCollectionViewCell {
    func insertNewRow() {
//        presenter?.reloadBills()
//        tableView.insertRows(at: [IndexPath(row: (presenter?.model.count)!, section: 0)], with:.automatic)
//        guard let count = presenter?.model?.count else { return }
//        let indexPath = IndexPath(row: count - 1, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
//        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
}

extension HomeViewCollectionViewCell: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        @unknown default:
            break
        }
    }
}
