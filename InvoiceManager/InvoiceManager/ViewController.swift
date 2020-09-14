//
//  ViewController.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let tableIdentifier = "tableViewCell"
    private var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private var someView: UIView = {
       let view = UIView()
        view.layer.borderWidth = 1
        return view
    }()
    
    private var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("dissmis", for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
     var testData: [Bill]? = testBills1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        view.addSubview(tableView)
        view.addSubview(someView)
        someView.addSubview(dismissButton)
        
        someView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        leading: view.safeAreaLayoutGuide.leadingAnchor,
                        trailing: view.safeAreaLayoutGuide.trailingAnchor,
                        size: CGSize(width: 0, height: 300))

        tableView.anchor(top: someView.safeAreaLayoutGuide.bottomAnchor,
                         leading: view.safeAreaLayoutGuide.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.safeAreaLayoutGuide.trailingAnchor,
                         padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))

        dismissButton.anchor(top: someView.topAnchor,
                             leading: someView.leadingAnchor,
                             trailing: someView.trailingAnchor,
                             size: CGSize(width: 0, height: 50))

        configureTableVIew()
        
    }
    
    private func configureTableVIew() {
//        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "\(HomeViewTableViewCell.self)", bundle: nil ), forCellReuseIdentifier: tableIdentifier)
        tableView.backgroundColor = .red
    }
    
    @objc private func dismissView() {
//        self.dismiss(animated: true, completion: nil)
        testData?.append(testBills3[0])
        tableView.insertRows(at: [IndexPath(row: testData!.count - 1, section: 0)], with: .automatic)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) as? HomeViewTableViewCell
        guard let data = testData?[indexPath.row] else { return UITableViewCell() }
        cell?.billNameLabel.text = data.billName
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy HH:mm"
        cell?.billDateLabel.text = dateFormatter.string(from: data.modifiedDate)
        cell?.billCategoryLabel.text = data.category.name
        cell?.billValueLabel.text = String(data.value)
        //        cell.textLabel?.text = String(indexPath.row)
        return cell!
    }
}

