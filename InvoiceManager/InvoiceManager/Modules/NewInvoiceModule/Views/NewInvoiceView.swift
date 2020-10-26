//
//  NewInvoiceView.swift
//  InvoiceManager
//
//  Created by Tianid on 16.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class NewInvoiceView: UIView {
    
    //MARK: - Properties
    private let invoiceMessage = "Invoice name is required."
    private let currencyMessage = "is required."
    
    private var invoiceTextField: DTTextField = {
        let textField = DTTextField()
        textField.placeholder = "Invoice name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.dtLayer.backgroundColor = UIColor(named: "CustomColor")?.cgColor
        return textField
    }()
    
    private var dropMenu: DropDownMenu = {
        let menu = DropDownMenu()
        menu.dataSourse = CurrencyList
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.backgroundColor = UIColor(named: "CustomColor")
        return menu
    }()
    
    private var starterBalance: DTTextField = {
        let textField = DTTextField()
        textField.placeholder = "Starter balance (Optional)"
        textField.inputView = NumericKeyboard(target: textField, useDecimalSeparator: false)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.dtLayer.backgroundColor = UIColor(named: "CustomColor")?.cgColor

        return textField
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureViewsConstraint()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    
    override func layoutSubviews() {
        invoiceTextField.dtLayer.backgroundColor = UIColor(named: "CustomColor")?.cgColor
        starterBalance.dtLayer.backgroundColor = UIColor(named: "CustomColor")?.cgColor
        super.layoutSubviews()
    }
    
    func getUIData() -> (String, Currency, String?)? {
        guard validateMainFields() else { return nil }
        
        guard let text = invoiceTextField.text else { return nil }
        guard text.count > 0 else { return nil }
        guard let currency = dropMenu.curentCurrency else { return nil }
        return (text, currency, starterBalance.text)
    }
    
    private func configureViewsConstraint() {
        addSubview(invoiceTextField)
        addSubview(dropMenu)
        addSubview(starterBalance)
        
        invoiceTextField.anchor(top: safeAreaLayoutGuide.topAnchor,
                                leading: safeAreaLayoutGuide.leadingAnchor,
                                trailing: safeAreaLayoutGuide.trailingAnchor,
                                padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
        
        dropMenu.anchor(top: invoiceTextField.bottomAnchor,
                        leading: invoiceTextField.leadingAnchor,
                        trailing: invoiceTextField.trailingAnchor,
                        padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        
        starterBalance.anchor(top: dropMenu.bottomAnchor,
                              leading: dropMenu.leadingAnchor,
                              trailing: dropMenu.trailingAnchor,
                              padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
    }
    
    private func configureView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    private func validateMainFields() -> Bool {
        
        var result = true
        
        if invoiceTextField.text!.isEmptyStr {
            invoiceTextField.showError(message: invoiceMessage)
            result = false
        }
        
        if dropMenu.curentCurrency == nil {
            dropMenu.showError(message: currencyMessage)
            result = false
        }
        
        return result
    }
    
    private func validateField(textField: UITextField, text: String?) {
        if let text = textField.text?.currencyInputFormatting() {
            textField.text = text
        }
    }
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return  }
        validateField(textField: sender, text: text)
    }
}
