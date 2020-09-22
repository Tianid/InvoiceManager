//
//  BillCategoryView.swift
//  InvoiceManager
//
//  Created by Tianid on 10.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class BillCategoryView: UIView {
    
    //MARK: - Properties
    var presenter: IBillCategoryPresenter?
    private var selectedIndex = -1
    private let tableIdentifier = "categoryCell"
    private var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        
        button.addTarget(self, action: #selector(dismissCategory), for: .touchUpInside)
        return button
    }()
    
    
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
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    
    private func configureConstraints() {
        addSubview(dismissButton)
        addSubview(tableView)
        
        dismissButton.anchor(top: safeAreaLayoutGuide.topAnchor,
                             centerX: centerXAnchor)
        
        tableView.anchor(top: dismissButton.safeAreaLayoutGuide.bottomAnchor,
                         leading: safeAreaLayoutGuide.leadingAnchor,
                         bottom: safeAreaLayoutGuide.bottomAnchor,
                         trailing: safeAreaLayoutGuide.trailingAnchor,
                         padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "\(BillCategoryTableViewCell.self)", bundle: nil), forCellReuseIdentifier: tableIdentifier)
    }
    
    @objc private func dismissCategory() {
        presenter?.dismissCategory()
    }
    
    
}

extension BillCategoryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.categorySelected(index: indexPath.row)
    }
}

extension BillCategoryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) as? BillCategoryTableViewCell
        cell?.categoryLabel.text = presenter?.model[indexPath.row].name
        return cell!
    }
}
