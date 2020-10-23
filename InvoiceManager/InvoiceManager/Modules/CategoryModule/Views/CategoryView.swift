//
//  CategoryView.swift
//  InvoiceManager
//
//  Created by Tianid on 23.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class CategoryView: UIView {
    
    //MARK: - Properties
    var presenter: ICategoryPresenter? {
        didSet {
            tableViewContainer.presenter = presenter as? ICategoryTableContainer
        }
    }
    
    var navigationItem: UINavigationItem? {
        willSet {
            tableViewContainer.navigationItem = newValue
        }
    }
    
    private var tableViewContainer: CategoryTableContainer = {
        let view = CategoryTableContainer()
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Func
    
    private func configureConstraints() {
        addSubview(tableViewContainer)
        
        tableViewContainer.anchor(top: safeAreaLayoutGuide.topAnchor,
                                  leading: safeAreaLayoutGuide.leadingAnchor,
                                  bottom: safeAreaLayoutGuide.bottomAnchor,
                                  trailing: safeAreaLayoutGuide.trailingAnchor,
                                  padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
    }
}
