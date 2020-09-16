//
//  DropDownMenu.swift
//  InvoiceManager
//
//  Created by Tianid on 16.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class DropDownMenu: UIView {
    
    //MARK: - Properties
    var dataSourse: [Currency]?
    
    private(set) var curentCurrency: Currency?
    private var tableViewHeightValue: CGFloat = 150
    private var tableViewHeightConstraint: NSLayoutConstraint!
    private let tableViewIndentifier = "tableViewIdentifier"
    private var dataLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.text = "Select currency..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "triangle"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        tableView.backgroundColor = .green
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    
    //MARK: - Init
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureConstraints()
        configureTableView()
        configureGestures()
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Func
    
    private func configureConstraints() {
        addSubview(containerView)
        containerView.addSubview(dataLabel)
        containerView.addSubview(imageView)
        addSubview(tableView)
        
        containerView.anchor(top: safeAreaLayoutGuide.topAnchor,
                             leading: safeAreaLayoutGuide.leadingAnchor,
                             trailing: safeAreaLayoutGuide.trailingAnchor
                             )
        
        dataLabel.anchor(top: containerView.topAnchor,
                         leading: containerView.leadingAnchor,
                         bottom: containerView.bottomAnchor,
                         trailing: imageView.leadingAnchor)
        
        imageView.anchor(
                         trailing: containerView.trailingAnchor,
                         size: CGSize(width: 15, height: 15),
                         centerY: dataLabel.centerYAnchor)
        
        tableView.anchor(top: containerView.bottomAnchor,
                         leading: containerView.leadingAnchor,
                         bottom: safeAreaLayoutGuide.bottomAnchor,
                         trailing: containerView.trailingAnchor)
        
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            tableViewHeightConstraint
        ])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewIndentifier)
    }
    
    private func configureGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showHideTableView))
        containerView.addGestureRecognizer(tap)
    }
    
    @objc private func showHideTableView(_ sender: UITapGestureRecognizer) {
        if tableViewHeightConstraint.constant == 0 {
            showTableView()
        } else {
            hideTableView()
        }
    }
    
    private func showTableView() {
        tableViewHeightConstraint.constant = tableViewHeightValue
        UIView.animate(withDuration: 0.2, animations: { [unowned self] in
            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
            self.superview?.layoutIfNeeded()
        })
    }
    
    private func hideTableView() {
        tableViewHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.2, animations: { [unowned self] in
            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
            self.superview?.layoutIfNeeded()
        })
    }
    
    
//    override func endEditing(_ force: Bool) -> Bool {
//        if force && tableViewHeightConstraint.constant != 0 {
//            hideTableView()
//            return true
//        }
//        return false
//    }
    
}


extension DropDownMenu: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        curentCurrency = dataSourse?[indexPath.row]
        dataLabel.text = curentCurrency?.rawValue
        hideTableView()
    }
}

extension DropDownMenu: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIndentifier, for: indexPath)
        cell.textLabel?.text = dataSourse?[indexPath.row].rawValue
        return cell
    }
}
