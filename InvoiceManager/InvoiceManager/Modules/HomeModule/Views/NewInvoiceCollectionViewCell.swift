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
    var presenter: ISPHomeView?
    private var addInvoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        return button
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraint()
        configureButton()
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
    
    private func configureButton() {
        addInvoiceButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        presenter?.newInvoiceButtonTapped()
    }
    
}
