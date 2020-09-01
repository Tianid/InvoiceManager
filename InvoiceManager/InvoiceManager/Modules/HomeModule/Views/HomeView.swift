//
//  HomeView.swift
//  InvoiceManager
//
//  Created by Tianid on 01.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class HomeView: UIView {
    //MARK: - Properties
    private let identifier = "collectionViewIdentifier"
    private let headerViewHeightConst = 200
    private let invoiceNameLabelYShift: CGFloat = -75
    
    private var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        
        return view
    }()
    
    private var invoiceNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SOME INVOICE"
        return label
    }()
    
    private var invoiceBalanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$123456"
        return label
    }()
    
    //MARK: Income
    private var invoiceIncomeImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.layer.borderWidth = 2
        
        return imageView
    }()
    
    private var invoiceIncomeWordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Income"
        return label
    }()
    
    private var invoiceIncomeCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$100"
        return label
    }()
    
    //MARK: Expense
    private var invoiceExpenseImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    private var invoiceExpenseWordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Expense"
        return label
    }()
    
    private var invoiceExpenseCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$2000"
        return label
    }()
    
    private var incomeExpenseContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        view.backgroundColor = .clear
        return view
    }()
    
    private var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.isPagingEnabled = true
        collection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collection.backgroundColor = .clear
        return collection
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureViewsConstraint()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    
    func configureViewsConstraint() {
        self.addSubview(headerView)
        headerView.addSubview(invoiceNameLabel)
        headerView.addSubview(invoiceBalanceLabel)
        headerView.addSubview(incomeExpenseContainer)
        
        incomeExpenseContainer.addSubview(invoiceIncomeImageView)
        incomeExpenseContainer.addSubview(invoiceIncomeWordLabel)
        incomeExpenseContainer.addSubview(invoiceIncomeCounterLabel)
        incomeExpenseContainer.addSubview(invoiceExpenseImageView)
        incomeExpenseContainer.addSubview(invoiceExpenseWordLabel)
        incomeExpenseContainer.addSubview(invoiceExpenseCounterLabel)
        self.addSubview(collectionView)
        
        
        
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor,
                          leading: safeAreaLayoutGuide.leadingAnchor,
                          trailing: safeAreaLayoutGuide.trailingAnchor,
                          size: CGSize(width: 0, height: headerViewHeightConst))
        
        invoiceNameLabel.anchor(top: headerView.topAnchor,
            padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0),
            centerX: headerView.centerXAnchor
        )
        
        invoiceBalanceLabel.anchor(top: invoiceNameLabel.bottomAnchor,
                                   centerX: invoiceNameLabel.centerXAnchor)
        
        
        
        incomeExpenseContainer.anchor(top: invoiceBalanceLabel.bottomAnchor, leading: headerView.leadingAnchor,
                                      trailing: headerView.trailingAnchor,
                                      padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8),
                                      size: CGSize(width: headerView.frame.size.width, height: 100))
        
        
        
        
        //MARK: 6 items in incomeExpenseContainer
        invoiceIncomeImageView.anchor(top: incomeExpenseContainer.topAnchor,
                                      leading: incomeExpenseContainer.leadingAnchor,
                                      padding: UIEdgeInsets(top: 4, left: 4, bottom: 0, right: 0),
                                      size: CGSize(width: 25, height: 25))
        
        invoiceIncomeWordLabel.anchor(top: invoiceIncomeImageView.topAnchor,
                                      leading: invoiceIncomeImageView.trailingAnchor,
                                      padding: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0),
                                      centerY: invoiceIncomeImageView.centerYAnchor)
        
        invoiceIncomeCounterLabel.anchor(top: invoiceIncomeWordLabel.bottomAnchor,
                                         leading: invoiceIncomeWordLabel.leadingAnchor)
        
        invoiceExpenseImageView.anchor(top: invoiceIncomeImageView.topAnchor,
                                       leading: invoiceIncomeWordLabel.trailingAnchor,
                                       size: CGSize(width: 25, height: 25))
        invoiceExpenseWordLabel.anchor(top: invoiceExpenseImageView.topAnchor,
                                       leading: invoiceExpenseImageView.trailingAnchor,
                                       trailing: incomeExpenseContainer.trailingAnchor,
                                       padding: UIEdgeInsets(top: 4, left: 4, bottom: 0, right: 2),
                                       centerY: invoiceExpenseImageView.centerYAnchor)
        
        invoiceExpenseCounterLabel.anchor(top: invoiceIncomeWordLabel.bottomAnchor,
                                          leading: invoiceExpenseWordLabel.leadingAnchor,
                                          trailing: incomeExpenseContainer.trailingAnchor)
        
        //MARK: collectionView constraints
        
        collectionView.anchor(top: headerView.bottomAnchor,
                              leading: leadingAnchor,
                              bottom: safeAreaLayoutGuide.bottomAnchor,
                              trailing: trailingAnchor,
                              padding: UIEdgeInsets(top: -30, left: 8, bottom: 0, right: 8))
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
    }
}

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 300)
    }
}
