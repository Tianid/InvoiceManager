//
//  BillDetailsView.swift
//  InvoiceManager
//
//  Created by Tianid on 08.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

enum BillState: Int {
    case income
    case expense
}

enum BillDetailsCreationState {
    case editing
    case creating
    case defaultState
}

import UIKit

class BillDetailsView: UIView {
    //MARK: - Properties
    
    var presenter: IBillDetailsPresenter?
    private let transition = PanelTransition()
    
    private let textViewMaxHeight: CGFloat = 200
    
    private var nameWordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    
    private var nameTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Enter name..."
        return text
    }()
    
    private var valueWordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Value"
        return label
    }()
    
    private var valueTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Enter value..."
        text.inputView = NumericKeyboard(target: text, useDecimalSeparator: true)
        text.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return text
    }()
    
    private var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Income", "Expense"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private var categoryWordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Category"
        return label
    }()
    
    private var categoryTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Select category..."
        text.isEnabled = true
//        text.addTarget(self, action: #selector(showCategoryActionSheet(_:)), for: .touchDown)
        return text
    }()
    
    private var testButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("push", for: .normal)
        button.addTarget(self, action: #selector(showCategoryActionSheet(_:)), for: .touchUpInside)
        return button
    }()
    
    private var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("save", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var descriptionWordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        return label
    }()
    
    private var descriptionTextField: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "test"
        text.isScrollEnabled = true
        return text
    }()
    
    
    private var viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureConstraints()
        valueTextField.inputAccessoryView = addDoneButtonOnKeyboard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Func
    
    func updateDetailFields() {
        guard let bill = presenter?.model else {
            presenter?.billDetailsCreationState = .creating
            return
        }
        presenter?.billDetailsCreationState = .editing

        let name = bill.billName
        var value = 0.0
        
        if bill.value < 0 {
            value = bill.value * -1
            segmentedControl.selectedSegmentIndex = 1
        } else {
            value = bill.value
            segmentedControl.selectedSegmentIndex = 0
        }
        
        let category = bill.category.name
        let description = bill.billDescription
        
        nameTextField.text = name
        valueTextField.text = String(value)
        categoryTextField.text = category
        descriptionTextField.text = description
        
    }
    
    func setCategory(name: String) {
        categoryTextField.text = name
    }
    
    private func configureConstraints() {
        self.addSubview(viewContainer)
        
        viewContainer.addSubview(nameWordLabel)
        viewContainer.addSubview(nameTextField)
        viewContainer.addSubview(valueWordLabel)
        viewContainer.addSubview(valueTextField)
        viewContainer.addSubview(segmentedControl)
        viewContainer.addSubview(categoryWordLabel)
        viewContainer.addSubview(categoryTextField)
        viewContainer.addSubview(descriptionWordLabel)
        viewContainer.addSubview(descriptionTextField)
        viewContainer.addSubview(testButton)
        viewContainer.addSubview(saveButton)
        
        
        
        viewContainer.anchor(top: safeAreaLayoutGuide.topAnchor,
                             leading: safeAreaLayoutGuide.leadingAnchor,
                             bottom: safeAreaLayoutGuide.bottomAnchor,
                             trailing: safeAreaLayoutGuide.trailingAnchor)
        
        segmentedControl.anchor(top: viewContainer.topAnchor,
                                leading: viewContainer.leadingAnchor,
                                trailing: viewContainer.trailingAnchor)
        
        nameWordLabel.anchor(top: segmentedControl.bottomAnchor,
                             leading: segmentedControl.leadingAnchor,
                             trailing: segmentedControl.trailingAnchor)
        
        nameTextField.anchor(top: nameWordLabel.bottomAnchor,
                             leading: nameWordLabel.leadingAnchor,
                             trailing: nameWordLabel.trailingAnchor)
        
        valueWordLabel.anchor(top: nameTextField.bottomAnchor,
                              leading: nameTextField.leadingAnchor,
                              trailing: nameTextField.trailingAnchor)
        
        valueTextField.anchor(top: valueWordLabel.bottomAnchor,
                              leading: valueWordLabel.leadingAnchor,
                              trailing: valueWordLabel.trailingAnchor)
        
        
        categoryWordLabel.anchor(top: valueTextField.bottomAnchor,
                                 leading: valueTextField.leadingAnchor,
                                 trailing: valueTextField.trailingAnchor)
        
        categoryTextField.anchor(top: categoryWordLabel.bottomAnchor,
                                 leading: categoryWordLabel.leadingAnchor,
                                 trailing: categoryWordLabel.trailingAnchor)
        
        testButton.anchor(top: categoryTextField.bottomAnchor,
                          leading: categoryTextField.leadingAnchor,
                          trailing: categoryTextField.trailingAnchor)
        
        saveButton.anchor(top: testButton.bottomAnchor,
                          leading: testButton.leadingAnchor,
                          trailing: testButton.trailingAnchor)
        
        descriptionWordLabel.anchor(top: saveButton.bottomAnchor,
                                    leading: categoryTextField.leadingAnchor,
                                    trailing: categoryTextField.trailingAnchor)
        
        descriptionTextField.anchor(top: descriptionWordLabel.bottomAnchor,
                                    leading: descriptionWordLabel.leadingAnchor,
                                    bottom: viewContainer.bottomAnchor,
                                    trailing: descriptionWordLabel.trailingAnchor
                                    )
        
    }
    
    private func addDoneButtonOnKeyboard() -> UIToolbar{
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction(_:)))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        return doneToolbar
    }
    
    @objc private func doneButtonAction(_ sender: UIBarButtonItem){
        self.viewContainer.endEditing(true)
    }
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        guard var text = sender.text else { return }
        let result = text.reduce(into: 0) { (result, value) in
            if value == "." {
                result += 1
            }
        }
        
        if result > 1 {
            text.removeLast()
            sender.text = String(text)
        }
    }
    
    @objc private func showCategoryActionSheet(_ sender: UIButton) {
        presenter?.categoryFieldTapped(transition: transition)
    }
    
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text else { return }
        guard let value = valueTextField.text else { return }
        guard let dValue = Double(value) else { return }
        let state = segmentedControl.selectedSegmentIndex
        let description = descriptionTextField.text
        let billState = state == BillState.income.rawValue ? BillState.income : BillState.expense
        
        presenter?.saveButtonTapped(name: name, value: dValue, billState: billState, description: description)
    }
    
}

extension BillDetailsView: UITextViewDelegate {
//    func textViewDidChange(_ textView: UITextView) {
//        if textView.contentSize.height >= self.textViewMaxHeight {
//            textView.isScrollEnabled = true
//        }
//        else {
//            textView.frame.size.height = textView.contentSize.height
//            textView.isScrollEnabled = false
//        }
//    }
}
