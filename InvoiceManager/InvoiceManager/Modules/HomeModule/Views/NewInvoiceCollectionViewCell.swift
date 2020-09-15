//
//  NewInvoiceCollectionViewCell.swift
//  InvoiceManager
//
//  Created by Tianid on 15.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class NewInvoiceCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    private var addInvoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        return button
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func

    private func configureConstraint() {
        contentView.addSubview(addInvoiceButton)
        
        addInvoiceButton.anchor(top: safeAreaLayoutGuide.topAnchor,
                                leading: safeAreaLayoutGuide.leadingAnchor,
                                bottom: safeAreaLayoutGuide.bottomAnchor,
                                trailing: safeAreaLayoutGuide.trailingAnchor)
    }
    
}
