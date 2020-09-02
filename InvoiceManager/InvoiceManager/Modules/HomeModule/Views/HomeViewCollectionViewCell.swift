//
//  HomeViewCollectionViewCell.swift
//  InvoiceManager
//
//  Created by Tianid on 02.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class HomeViewCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
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
        return Int.random(in: 5..<20)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) as? HomeViewTableViewCell
        cell?.billNameLabel.text = "SOME NAME"
        cell?.billDateLabel.text = "1 may 2945 at 23:00"
        cell?.billCategoryLabel.text = "SOME CATEGORY"
        cell?.billValueLabel.text = "10000000009$"
        //        cell.textLabel?.text = String(indexPath.row)
        return cell!
    }
}
//MARK: - UITableViewDelegate
extension HomeViewCollectionViewCell: UITableViewDelegate {
    
}
