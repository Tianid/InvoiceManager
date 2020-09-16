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
    
    private var invoiceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter invice namey"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var dropMenu: DropDownMenu = {
        let menu = DropDownMenu()
        menu.dataSourse = testCurrency
        menu.translatesAutoresizingMaskIntoConstraints = false
        return menu
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureViewsConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    
    func getUIData() -> (String, Currency)? {
        guard let text = invoiceTextField.text else { return nil }
        guard text.count > 0 else { return nil }
        guard let currency = dropMenu.curentCurrency else { return nil }
        return (text, currency)
    }
    
    private func configureViewsConstraint() {
        addSubview(invoiceTextField)
        addSubview(dropMenu)
        
        invoiceTextField.anchor(top: safeAreaLayoutGuide.topAnchor,
                                leading: safeAreaLayoutGuide.leadingAnchor,
                                trailing: safeAreaLayoutGuide.trailingAnchor,
                                padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
        
        dropMenu.anchor(top: invoiceTextField.bottomAnchor,
                        leading: invoiceTextField.leadingAnchor,
                        trailing: invoiceTextField.trailingAnchor)
    }
}
