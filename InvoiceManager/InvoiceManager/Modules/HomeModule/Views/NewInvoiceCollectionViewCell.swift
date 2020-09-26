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
    var presenter: IHomePresenter?
    private var addInvoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.borderWidth = 3
        button.layer.borderColor  = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        return button
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraint()
        configureButton()
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func

    private func configureConstraint() {
        contentView.addSubview(addInvoiceButton)
        
        addInvoiceButton.anchor(size: CGSize(width: 100, height: 100),
                                centerX: centerXAnchor,
                                centerY: centerYAnchor)
    }
    
    private func configureUI() {
        addInvoiceButton.layer.cornerRadius = 50 / 4
    }
    
    private func configureButton() {
        addInvoiceButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        presenter?.showNewInvoice()
    }
    
}
