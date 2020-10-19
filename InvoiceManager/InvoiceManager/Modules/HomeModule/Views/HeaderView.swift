//
//  HeaderView.swift
//  InvoiceManager
//
//  Created by Tianid on 19.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    //MARK: - Properties
    var bottomBorder: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(named: "CustomBorder")
        return view
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
    private func configureViewsConstraint() {
        addSubview(bottomBorder)
        bottomBorder.anchor(
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor,
            size: CGSize(width: 0, height: 1))
    }
    
}
