//
//  CategoryView.swift
//  InvoiceManager
//
//  Created by Tianid on 23.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class CategoryView: UIView {

    //MARK: - Properties
    private let categoryTableIdentifier = "categoryTableIdentifier"
    
    private var panelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    private var categorysWordlabel: UILabel = {
        let label = UILabel()
        label.text = "Categorys"
        label.backgroundColor = .yellow
        return label
    }()
    
    private var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .red
        return table
    }()
    
    //MARK: - Init
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Func

    private func configureConstraints() {
        addSubview(panelView)
        panelView.addSubview(categorysWordlabel)
        addSubview(tableView)
        
        panelView.anchor(top: safeAreaLayoutGuide.topAnchor,
                         leading: safeAreaLayoutGuide.leadingAnchor,
                         trailing: safeAreaLayoutGuide.trailingAnchor,
                         size: CGSize(width: 0, height: 200))
        
        categorysWordlabel.anchor(top: panelView.topAnchor,
                                  leading: panelView.leadingAnchor,
                                  bottom: panelView.bottomAnchor,
                                  trailing: panelView.trailingAnchor,
                                  padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        
        tableView.anchor(top: panelView.bottomAnchor,
                         leading: safeAreaLayoutGuide.leadingAnchor,
                         bottom: safeAreaLayoutGuide.bottomAnchor,
                         trailing: safeAreaLayoutGuide.trailingAnchor,
                         padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    private func configureViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: categoryTableIdentifier)
    }

}

extension CategoryView: UITableViewDelegate {
    
}

extension CategoryView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "test"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryTableIdentifier, for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
}
