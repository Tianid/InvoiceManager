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
    var presenter: ISPHomeView?
    private let identifier = "collectionViewIdentifier"
    
    private var curentPage: CGFloat = 0 {
        didSet {
            setupInvoiceData()
        }
    }
    private let headerViewHeightConst = 200
    private let invoiceNameLabelYShift: CGFloat = -75
    
    private var headerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
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
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.isPagingEnabled = true
        collection.backgroundColor = .clear
        return collection
    }()
    
    private var collectionPanel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.backgroundColor = .red
        return view
    }()
    
    private var addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addNewBill(_:)), for: .touchUpInside)
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "plus.app"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        button.backgroundColor = .green
        return button
    }()
    
    
    
    //MARK: - Init
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureViewsConstraint()
        configureCollectionView()
        setupInvoiceData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    
    func deleteRowInTableView(invoiceIndex: Int, billIndex: Int) {
        let cell = collectionView.cellForItem(at: IndexPath(row: invoiceIndex, section: 0)) as? HomeViewCollectionViewCell
        cell?.deleteRowInTableView(billIndex: billIndex)
    }
    
    func refreshTableViewByIndex(invoiceIndex: Int, billIndex: Int) {
        let cell = collectionView.cellForItem(at: IndexPath(row: invoiceIndex, section: 0)) as? HomeViewCollectionViewCell
        cell?.refreshTableViewByBillIndex(billIndex: billIndex)
    }
    
    func insertNewDataInTable(index: Int) {
        let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? HomeViewCollectionViewCell
        cell?.insertNewRow()
    }
    
    func viewWillTransition() {
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    private func configureViewsConstraint() {
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
        headerView.addSubview(collectionPanel)
        collectionPanel.addSubview(addButton)
        
        
        
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



        incomeExpenseContainer.anchor(top: invoiceBalanceLabel.bottomAnchor,
                                      leading: headerView.leadingAnchor,
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

        collectionPanel.anchor(top: incomeExpenseContainer.bottomAnchor,
                               leading: incomeExpenseContainer.leadingAnchor,
                               bottom: headerView.bottomAnchor,
                               trailing: incomeExpenseContainer.trailingAnchor
                               )

        addButton.anchor(top: collectionPanel.safeAreaLayoutGuide.topAnchor,
                         leading: collectionPanel.leadingAnchor,
                         trailing: collectionPanel.trailingAnchor)
        
        //MARK: collectionView constraints
        
        collectionView.anchor(top: headerView.safeAreaLayoutGuide.bottomAnchor,
                              leading: safeAreaLayoutGuide.leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: safeAreaLayoutGuide.trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeViewCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        
    }
    
    private func setupInvoiceData() {
        guard curentPage <= CGFloat(testInvoices.count) else { return }
        let data = testInvoices[Int(curentPage)]
        invoiceNameLabel.text = data.name
        invoiceBalanceLabel.text = String(data.balance)
        
    }
    
    @objc private func addNewBill(_ sender: UIButton) {
        presenter?.showBillDetail(bill: nil, billIndex: nil)
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
    }
    
    
}
//MARK: - UICollectionViewDataSource
extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.model.invoices.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? HomeViewCollectionViewCell
        cell?.presenter = presenter?.generateSPHomeViewCell(index: indexPath.row)
        //        cell?.testData = presenter?.model[indexPath.row].bills
        return cell!
    }
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        
        let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right
        
        let referenceHeight = collectionView.safeAreaLayoutGuide.layoutFrame.height
            - sectionInset.top
            - sectionInset.bottom
            - collectionView.contentInset.top
            - collectionView.contentInset.bottom
        
        return CGSize(width: referenceWidth, height: referenceHeight)
    }
}

//MARK: - UIScrollViewDelegate
extension HomeView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.size.width
        curentPage = collectionView.contentOffset.x / pageWidth
        presenter?.setInvoiceIndex(invoiceIndex: Int(curentPage))
    }
}

extension HomeView: IHomeView {
    func insertNewBill(index: Int) {
        guard let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? IHomeViewCollectionViewCell else { return }
        cell.insertNewRow()
        
    }
}
