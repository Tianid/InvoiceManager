//
//  ViewController.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var context: NSManagedObjectContext! {
        didSet {
            
            let requeset = NSFetchRequest<CDSection>(entityName: "\(CDSection.self)")
            let sections = try! context.fetch(requeset)
            
            let requesetCategory = NSFetchRequest<CDCategory>(entityName: "\(CDCategory.self)")
            let category = try! context.fetch(requesetCategory)
            
            coreDataSections = category
            tableView.reloadData()
        }
    }
    
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
    
    private var dropMenu: DropDownMenu = {
       return DropDownMenu()
    }()
    
    private var nameTextField: DTTextField = {
        let text = DTTextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Category"
        text.isEnabled = true
        //        text.addTarget(self, action: #selector(showCategoryActionSheet(_:)), for: .touchDown)
        return text
    }()
    
    private var valueTextField: DTTextField = {
        let text = DTTextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Category"
        text.isEnabled = true
        //        text.addTarget(self, action: #selector(showCategoryActionSheet(_:)), for: .touchDown)
        return text
    }()
    
    private var categoryTextField: DTTextField = {
        let text = DTTextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Category"
        text.isEnabled = true
        //        text.addTarget(self, action: #selector(showCategoryActionSheet(_:)), for: .touchDown)
        return text
    }()
    
    private var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add data", for: .normal)
        button.addTarget(self, action: #selector(addNewDataToCD), for: .touchUpInside)
        return button
    }()
    
    var testData: [Bill]? = testBills1
    var coreDataSections: [CDCategory] = [CDCategory]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
//        view.addSubview(dropMenu)
//        view.addSubview(nameTextField)
//        view.addSubview(valueTextField)
//        view.addSubview(categoryTextField)
//        dropMenu.dataSourse = [.EUR, .GBP, .RUB, .USD]
//        nameTextField.delegate = self
//
//        NotificationCenter.default.addObserver(self, selector: #selector(test), name: UIResponder.keyboardWillShowNotification, object: nil)
        
//        dropMenu.anchor(top: view.safeAreaLayoutGuide.topAnchor,
//                        leading: view.safeAreaLayoutGuide.leadingAnchor,
//                        trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
//        dropMenu.anchor(size: CGSize(width: 100, height: 0), centerX: view.centerXAnchor)
        
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideDropMenu)))
        
        
//        nameTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor,
//                             leading: view.safeAreaLayoutGuide.leadingAnchor,
//                             trailing: view.safeAreaLayoutGuide.trailingAnchor,
//                             padding: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0))
        

        
//        nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  50).isActive = true
//        nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant:  8).isActive = true
//        nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -8).isActive = true
//        nameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true


        
//
//        valueTextField.anchor(top: nameTextField.bottomAnchor,
//                              leading: view.safeAreaLayoutGuide.leadingAnchor,
//                              trailing: view.safeAreaLayoutGuide.trailingAnchor,
//                              padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right:8))
//
//        categoryTextField.anchor(top: valueTextField.bottomAnchor,
//                                 leading: valueTextField.leadingAnchor,
//                                 trailing: valueTextField.trailingAnchor,
//                                 padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        
        
        
        
        view.addSubview(tableView)
        view.addSubview(someView)
        someView.addSubview(dismissButton)
        someView.addSubview(addButton)

        someView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        leading: view.safeAreaLayoutGuide.leadingAnchor,
                        trailing: view.safeAreaLayoutGuide.trailingAnchor,
                        size: CGSize(width: 0, height: 100))

        tableView.anchor(top: someView.safeAreaLayoutGuide.bottomAnchor,
                         leading: view.safeAreaLayoutGuide.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.safeAreaLayoutGuide.trailingAnchor,
                         padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))

        dismissButton.anchor(top: someView.topAnchor,
                             leading: someView.leadingAnchor,
                             trailing: someView.trailingAnchor,
                             size: CGSize(width: 0, height: 50))
        
        addButton.anchor(top: dismissButton.bottomAnchor,
                         leading: dismissButton.leadingAnchor,
                         trailing: dismissButton.trailingAnchor,
                         size: CGSize(width: 0, height: 50))

        configureTableVIew()
        
    }
    
    @objc func addNewDataToCD() {
        let category = NSEntityDescription.insertNewObject(forEntityName: "\(CDCategory.self)", into: context) as? CDCategory
        
        category?.name = "category NAME1 \(Int.random(in: 0...1000))"
        category?.iconImageName = "iconImage NAME1 \(Int.random(in: 0...1000))"
        
        
        let section = NSEntityDescription.insertNewObject(forEntityName: "\(CDSection.self)", into: context) as? CDSection
        
        section?.name = "section NAME1 \(Int.random(in: 0...1000))"
        
        category?.section = section
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    @objc func test(notification: NSNotification) {
        print("test")
    }
    
    private func configureTableVIew() {
//        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "\(HomeViewTableViewCell.self)", bundle: nil ), forCellReuseIdentifier: tableIdentifier)
        tableView.backgroundColor = .red
    }
    @objc private func hideDropMenu() {
//        let _ = dropMenu.endEditing(true)
    }
    @objc private func dismissView() {
//        self.dismiss(animated: true, completion: nil)
        testData?.append(testBills3[0])
        tableView.insertRows(at: [IndexPath(row: testData!.count - 1, section: 0)], with: .automatic)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) as? HomeViewTableViewCell
        cell?.billNameLabel.text = coreDataSections[indexPath.row].name
        cell?.billCategoryLabel.text = coreDataSections[indexPath.row].iconImageName
        cell?.billDateLabel.text = coreDataSections[indexPath.row].section?.name
        return cell!
        
        
//        guard let data = testData?[indexPath.row] else { return UITableViewCell() }
//        cell?.billNameLabel.text = data.billName
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "d MMM yyyy HH:mm"
//        cell?.billDateLabel.text = dateFormatter.string(from: data.modifiedDate)
//        cell?.billCategoryLabel.text = data.category.name
//        cell?.billValueLabel.text = String(data.value)
//        //        cell.textLabel?.text = String(indexPath.row)
//        return cell!
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
    }
}

