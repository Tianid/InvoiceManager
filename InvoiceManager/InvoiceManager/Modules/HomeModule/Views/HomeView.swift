//
//  HomeView.swift
//  InvoiceManager
//
//  Created by Tianid on 01.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import CoreData

class HomeView: UIView {
    //MARK: - Properties
//    var presenter: ISPHomeView?
    var presenter: IHomePresenter?
    var context: NSManagedObjectContext! {
        didSet {
            setupFetchResultsController(for: context)
            fetchData()
            refreshUIData()
        }
    }
    
    private var fetchedResultsController: NSFetchedResultsController<CDInvoice>?

    private let identifier = "collectionViewIdentifier"
    private let newInvoiceIdentifier = "NewInvoiceCellIdentifier"
    
    private var moreTransition = PanelTransition()
    
    private var curentPage: CGFloat = 0 {
        didSet {
            
            if Int(curentPage) <= (presenter?.model.count)! - 1 {
                setupInvoiceData()
            }
            
//            if Int(curentPage) <= (presenter?.model.invoices.count)! - 1 {
//                setupInvoiceData()
//            }
        }
    }
    private let headerViewHeightConst = 200
    private let invoiceNameLabelYShift: CGFloat = -75
    
    private var headerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
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
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(systemName: "arrow.down.left.circle")
        } else {
            // Fallback on earlier versions
        }
        
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .green
        
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
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(systemName: "arrow.up.right.circle")
        } else {
            // Fallback on earlier versions
        }
        
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .red
        
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
        return button
    }()
    
    private var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openMoreMenu(_:)), for: .touchUpInside)
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        
        return button
    }()
    
    private var mockView: UIView?
    
    
    //MARK: - Init
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureViewsConstraint()
        configureCollectionView()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    
    func insertNewInvoice() {
//        guard let sections = fetchedResultsController?.sections else { return }
//        let count = sections[0].numberOfObjects
//        let indexPath = IndexPath(row: count, section: 0)

        
//        collectionView.insertItems(at: [indexPath])
//        collectionView.reloadData()
//        presenter?.setInvoiceIndex(invoiceIndex: Int(curentPage))
        refreshUIData()
    }
    
    func refreshUIData() {
        setupInvoiceData()
        configureMockViewIfNeeded()
    }
    
    func deleteRowInTableView(invoiceIndex: Int, billIndex: Int) {
        let cell = collectionView.cellForItem(at: IndexPath(row: invoiceIndex, section: 0)) as? HomeViewCollectionViewCell
        cell?.deleteRowInTableView(billIndex: billIndex)
        refreshUIData()
    }
    
    func refreshTableViewByIndex(invoiceIndex: Int, billIndex: Int) {
        let cell = collectionView.cellForItem(at: IndexPath(row: invoiceIndex, section: 0)) as? HomeViewCollectionViewCell
        cell?.refreshTableViewByBillIndex(billIndex: billIndex)
        refreshUIData()
    }
    
    func insertNewDataInTable(index: Int) {
        let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? HomeViewCollectionViewCell
        cell?.insertNewRow()
        refreshUIData()
    }
    
    func viewWillTransition() {
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    private func fetchData() {
        try! fetchedResultsController?.performFetch()
        collectionView.reloadData()
    }
    
    private func setupFetchResultsController(for context: NSManagedObjectContext) {
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        let request = NSFetchRequest<CDInvoice>(entityName: "\(CDInvoice.self)")
        request.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        fetchedResultsController?.delegate = self
    }
    
    private func configureViewsConstraint() {
        self.addSubview(headerView)
        headerView.addSubview(invoiceNameLabel)
        headerView.addSubview(invoiceBalanceLabel)
        headerView.addSubview(incomeExpenseContainer)
        headerView.addSubview(moreButton)
        
        
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
                          padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8),
                          size: CGSize(width: 0, height: 0))
        
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
                                      size: CGSize(width: headerView.frame.size.width, height: 0))
        
        moreButton.anchor(top: invoiceNameLabel.topAnchor,
                          bottom: invoiceNameLabel.bottomAnchor,
                          trailing: incomeExpenseContainer.trailingAnchor)
        
        
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
                                         leading: invoiceIncomeWordLabel.leadingAnchor,
                                         bottom: incomeExpenseContainer.bottomAnchor)
        
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
                               trailing: incomeExpenseContainer.trailingAnchor,
                               padding: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        )
        
        addButton.anchor(top: collectionPanel.topAnchor,
                         leading: collectionPanel.leadingAnchor,
                         bottom:  collectionPanel.bottomAnchor,
                         trailing: collectionPanel.trailingAnchor)
        
        //MARK: collectionView constraints
        
        collectionView.anchor(top: headerView.safeAreaLayoutGuide.bottomAnchor,
                              leading: headerView.leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: headerView.trailingAnchor,
                              padding: UIEdgeInsets(top: -13, left: 0, bottom: 20, right: 0))
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeViewCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.register(NewInvoiceCollectionViewCell.self, forCellWithReuseIdentifier: newInvoiceIdentifier)
        
        
    }
    
    private func configureUI() {
        headerView.layer.cornerRadius = CGFloat(headerViewHeightConst / 10)
    }
    
    private func setupInvoiceData() {
        guard let count = presenter?.model.count else { return }
        guard curentPage < CGFloat(count) && count > 0 else { return }
        guard let data = presenter?.model[Int(curentPage)] else { return }
        print(data.name)
        invoiceNameLabel.text = data.name
        invoiceBalanceLabel.text = String(data.balance)
        invoiceIncomeCounterLabel.text = String(data.income)
        invoiceExpenseCounterLabel.text = String(data.expense)
        
    }
    
    private func configureMockViewIfNeeded() {
        let count = collectionView.numberOfItems(inSection: 0)
        if count <= 0 {
            isNeedToInitMockView(true)
            
        } else if Int(curentPage) == count {
            isNeedToInitMockView(true)
            
        } else {
            isNeedToInitMockView(false)
        }
    }
    
    @objc private func addNewBill(_ sender: UIButton) {
        let indexPath = IndexPath(row: Int(curentPage), section: 0)
        guard let invoice = fetchedResultsController?.object(at: indexPath) else { return }

        presenter?.showBillDetail(invoice: invoice, bill: nil)
    }
    
    @objc private func openMoreMenu(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let renameAction = UIAlertAction(title: "Rename invoice", style: .default) { (_) in
            self.showRenameAlert()
        }
        
        let deleteAction = UIAlertAction(title: "Delete invoice", style: .default) { (_) in
//            self.presenter?.deleteInvoice(invoiceIndex: Int(self.curentPage), complition: { [weak self] in
//                self?.collectionView.deleteItems(at: [IndexPath(row: Int(self!.curentPage), section: 0)])
//                self?.refreshUIData()
//            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(renameAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        presenter?.presentAlert(alert: alert)
    }
    
    private func showRenameAlert() {
        let alert = UIAlertController(title: "Rename invoice", message: nil, preferredStyle: .alert)
        alert.addTextField { [unowned self] (textField) in
            textField.text = self.presenter?.model[Int(self.curentPage)].name
        }
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let text = alert?.textFields![0].text
//            self.presenter?.setNewName(name: text!, invoiceIndex: Int(self.curentPage), complition: { [weak self] in
//                self?.setupInvoiceData()
//            })
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        presenter?.presentAlert(alert: alert)
    }
    
    private func isNeedToInitMockView(_ value: Bool) {
        if value && mockView == nil {
            let view = HomeView.generateMockView()
            headerView.addSubview(view)
            view.anchor(top: headerView.topAnchor,
                        leading: headerView.leadingAnchor,
                        bottom: headerView.bottomAnchor,
                        trailing: headerView.trailingAnchor)
            view.layer.cornerRadius = CGFloat(headerViewHeightConst / 10)
            mockView = view
        } else if !value && mockView != nil {
            mockView?.removeFromSuperview()
            mockView = nil
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
    }
    
    
}
//MARK: - UICollectionViewDataSource
extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController?.sections else { return 0 }
        return sections[section].numberOfObjects + 1
//        guard let count = presenter?.model.count else { return 1 }
//        return count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let value = collectionView.numberOfItems(inSection: indexPath.section)
        if indexPath.row == value - 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newInvoiceIdentifier, for: indexPath) as? NewInvoiceCollectionViewCell
            cell?.presenter = presenter
            return cell!
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? HomeViewCollectionViewCell
        guard let invoice = fetchedResultsController?.object(at: indexPath) else { return cell!}
        cell?.presenter = presenter?.generateCellPresenter(invoice: invoice)
        cell?.context = context
//        cell?.presenter =
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
        if Int(curentPage) < collectionView.numberOfItems(inSection: 0) - 1 {
            presenter?.setInvoiceIndex(invoiceIndex: Int(curentPage))
            isNeedToInitMockView(false)
        } else {
            isNeedToInitMockView(true)
        }
    }
}

extension HomeView: IHomeView {
    func insertNewBill(index: Int) {
        guard let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? IHomeViewCollectionViewCell else { return }
        cell.insertNewRow()
        
    }
    
    fileprivate static func generateMockView() -> UIView {
        let view = UIView()
        let label = UILabel()
        label.text = "Create new Invoice"
        view.addSubview(label)
        label.anchor(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }
}


extension HomeView: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            collectionView.insertItems(at: [newIndexPath!])
        case .update:
            collectionView.reloadItems(at: [indexPath!])
        case .move:
            collectionView.deleteItems(at: [indexPath!])
            collectionView.insertItems(at: [newIndexPath!])
        case .delete:
            collectionView.deleteItems(at: [indexPath!])
        @unknown default:
            break
        }
    }
}
