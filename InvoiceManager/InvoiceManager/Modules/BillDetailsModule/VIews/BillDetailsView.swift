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
    
    private var keyboardHeight: CGRect = CGRect()
    private let nameMessage = "Name is required."
    private let valueMessage = "Value is required."
    private let categoryMessage = "Category is required."
    private let descriptionPlaceholdeer = "Enter description"
    
    private let transition = PanelTransition()
    
    private let textViewMaxHeight: CGFloat = 200
    
    private var nameTextField: DTTextField = {
        let text = DTTextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Name"
        return text
    }()
    
    private var valueTextField: DTTextField = {
        let text = DTTextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Value"
        text.inputView = NumericKeyboard(target: text, useDecimalSeparator: false)
        text.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return text
    }()
    
    private var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Income", "Expense"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private var categoryTextField: DTTextField = {
        let text = DTTextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Category"
        text.isUserInteractionEnabled = false
        text.isEnabled = true
        return text
    }()
    
    private var selectCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select", for: .normal)
        button.addTarget(self, action: #selector(showCategoryActionSheet(_:)), for: .touchUpInside)
        return button
    }()
    
    private var descriptionWordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description (Optional)"
        return label
    }()
    
    private var descriptionTextView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isScrollEnabled = true
        
        text.layer.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
        text.layer.borderWidth = 0.5
        text.layer.cornerRadius = 4.5
        
        return text
    }()
    
    
    private var viewContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureConstraints()
        valueTextField.inputAccessoryView = addDoneButtonOnKeyboard()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Func
    
    func saveButtonTapped() {
        guard validateFields() else { return }
        guard let name = nameTextField.text else { return }
        guard let value = valueTextField.text else { return }
        let dValue = value.formattedStringToDouble()
        let state = segmentedControl.selectedSegmentIndex
        let description = descriptionTextView.text
        let billState = state == BillState.income.rawValue ? BillState.income : BillState.expense
        
        presenter?.saveButtonTapped(name: name, value: dValue, billState: billState, description: description)
    }
    
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
        valueTextField.text = String(value).currencySetFormatting(currencySymbol: nil)
        categoryTextField.text = category
        descriptionTextView.text = description
        descriptionTextView.textColor = .black
        
    }
    
    func setCategory(name: String) {
        categoryTextField.text = name
    }
    
    private func configureConstraints() {
        self.addSubview(viewContainer)
        
        viewContainer.addSubview(nameTextField)
        viewContainer.addSubview(valueTextField)
        viewContainer.addSubview(segmentedControl)
        viewContainer.addSubview(categoryTextField)
        viewContainer.addSubview(descriptionWordLabel)
        viewContainer.addSubview(descriptionTextView)
        viewContainer.addSubview(selectCategoryButton)
        
        viewContainer.anchor(top: safeAreaLayoutGuide.topAnchor,
                             leading: safeAreaLayoutGuide.leadingAnchor,
                             bottom: safeAreaLayoutGuide.bottomAnchor,
                             trailing: safeAreaLayoutGuide.trailingAnchor)
        
        segmentedControl.anchor(top: viewContainer.topAnchor,
                                leading: viewContainer.leadingAnchor,
                                trailing: viewContainer.trailingAnchor,
                                padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
        
        nameTextField.anchor(top: segmentedControl.bottomAnchor,
                             leading: segmentedControl.leadingAnchor,
                             trailing: segmentedControl.trailingAnchor,
                             padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        
        valueTextField.anchor(top: nameTextField.bottomAnchor,
                              leading: nameTextField.leadingAnchor,
                              trailing: nameTextField.trailingAnchor,
                              padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        
        categoryTextField.anchor(top: valueTextField.bottomAnchor,
                                 leading: valueTextField.leadingAnchor,
                                 padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        
        selectCategoryButton.anchor(
            leading: categoryTextField.trailingAnchor,
            trailing: valueTextField.trailingAnchor,
            size: CGSize(width: 60, height: 0),
            centerY: categoryTextField.centerYAnchor)
        
        descriptionWordLabel.anchor(top: categoryTextField.bottomAnchor,
                                    leading: categoryTextField.leadingAnchor,
                                    trailing: selectCategoryButton.trailingAnchor,
                                    padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        
        descriptionTextView.anchor(top: descriptionWordLabel.bottomAnchor,
                                   leading: descriptionWordLabel.leadingAnchor,
                                   trailing: descriptionWordLabel.trailingAnchor,
                                   padding: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0),
                                   size: CGSize(width: 0, height: 150)
        )
    }
    
    private func configureViews() {
        descriptionTextView.text = descriptionPlaceholdeer //Placeholder
        descriptionTextView.textColor = UIColor.lightGray
        descriptionTextView.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
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
    
    private func validateFields() -> Bool {
        
        var result = true
        
        if nameTextField.text!.isEmptyStr {
            nameTextField.showError(message: nameMessage)
            result = false
        }
        
        if valueTextField.text!.isEmptyStr {
            valueTextField.showError(message: valueMessage)
            result = false
        }
        
        if categoryTextField.text!.isEmptyStr {
            categoryTextField.showError(message: categoryMessage)
            result = false
        }
        
        return result
    }
    
    private func moveViewUp() {
        let keyboardViewEndFrame = self.convert(self.keyboardHeight, from: self.window)
        if descriptionTextView.frame.maxY + 44 > keyboardViewEndFrame.origin.y {
            let freeSpaceSize = self.frame.maxY - descriptionTextView.frame.maxY
            let value = keyboardViewEndFrame.height - freeSpaceSize + self.safeAreaInsets.top + 6
            UIView.animate(withDuration: 0.47) {
                self.frame.origin.y -= value < 0 ? value * -1: value
            }
        }
    }
    
    private func validateField(textField: UITextField, text: String?) {
        if let text = textField.text?.currencyInputFormatting() {
            textField.text = text
        }
    }
    
    @objc private func doneButtonAction(_ sender: UIBarButtonItem){
        self.viewContainer.endEditing(true)
    }
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        validateField(textField: sender, text: text)
    }
    
    @objc private func showCategoryActionSheet(_ sender: UIButton) {
        presenter?.categoryFieldTapped(transition: transition)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.keyboardHeight = keyboardSize
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.frame.origin.y != 0 {
            self.frame.origin.y = 0
        }
    }
}

extension BillDetailsView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        moveViewUp()
        
        if descriptionTextView.textColor == UIColor.lightGray {
            descriptionTextView.text = ""
            descriptionTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if descriptionTextView.text == "" {
            descriptionTextView.text = descriptionPlaceholdeer
            descriptionTextView.textColor = UIColor.lightGray
        }
    }
}
