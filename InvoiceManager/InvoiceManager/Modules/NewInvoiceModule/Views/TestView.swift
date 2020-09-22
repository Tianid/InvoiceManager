//
//  TestView.swift
//  InvoiceManager
//
//  Created by Tianid on 22.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class TestView: UIView {
    private var tableViewHeightValue: CGFloat = 150
    private var tableViewHeightConstraint: NSLayoutConstraint!
    
    var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .red
        view.layer.cornerRadius = 4.5
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
        return view
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.backgroundColor = .yellow
        return tableView
    }()
    
    var label: UILabel = {
       let view = UILabel()
        view.text = "TEST"
//        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "triangle"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

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
    
    func configureConstraints() {
        addSubview(container)
        container.addSubview(label)
        container.addSubview(tableView)
        container.addSubview(imageView)
        
        container.anchor(top: topAnchor,
                         leading: leadingAnchor,
//                         bottom: bottomAnchor,
                         trailing: trailingAnchor)

        label.anchor(top: container.topAnchor,
                     leading: container.leadingAnchor)

//                     trailing: container.trailingAnchor)
        
        
        imageView.anchor(
                         trailing: container.trailingAnchor,
                         size: CGSize(width: 15, height: 15),
                         centerY: label.centerYAnchor)

        tableView.anchor(top: label.bottomAnchor,
                         leading: label.leadingAnchor,
                         bottom: container.bottomAnchor,
                         trailing: label.trailingAnchor)
        
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            tableViewHeightConstraint
        ])
        
    }
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TEST")
    }
    func configureGestures(){
                let tap = UITapGestureRecognizer(target: self, action: #selector(showHideTableView))
                container.addGestureRecognizer(tap)
        //        dataLabel.addGestureRecognizer(tap)
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
//             self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
             self.superview?.layoutIfNeeded()
         })
     }
     
     private func hideTableView() {
         tableViewHeightConstraint.constant = 0
         UIView.animate(withDuration: 0.2, animations: { [unowned self] in
//             self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
             self.superview?.layoutIfNeeded()
         })
     }
}

extension TestView: UITableViewDelegate {
    
}

extension TestView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TEST")
        cell?.textLabel?.text = String(indexPath.row)
//        cell?.backgroundColor = .green
        return cell!
    }
    
}
