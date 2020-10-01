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
    
    private var panelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    private var categorysWordlabel: UILabel = {
        let label = UILabel()
        label.text = "Categorys"
        label.backgroundColor = .yellow
        return label
    }()
    
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
        addSubview(panelView)
        panelView.addSubview(categorysWordlabel)
        addSubview(tableViewContainer)
        
        panelView.anchor(top: safeAreaLayoutGuide.topAnchor,
                         leading: safeAreaLayoutGuide.leadingAnchor,
                         trailing: safeAreaLayoutGuide.trailingAnchor,
                         size: CGSize(width: 0, height: 200))
        
        categorysWordlabel.anchor(top: panelView.topAnchor,
                                  leading: panelView.leadingAnchor,
                                  bottom: panelView.bottomAnchor,
                                  trailing: panelView.trailingAnchor,
                                  padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        
        tableViewContainer.anchor(top: panelView.bottomAnchor,
                                  leading: safeAreaLayoutGuide.leadingAnchor,
                                  bottom: safeAreaLayoutGuide.bottomAnchor,
                                  trailing: safeAreaLayoutGuide.trailingAnchor,
                                  padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
}
