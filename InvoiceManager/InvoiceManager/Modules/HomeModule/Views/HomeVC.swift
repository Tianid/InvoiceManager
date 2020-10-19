//
//  HomeVC.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    //MARK: - Properties
    var presenter: IHomePresenter?
    
    private var homeView: HomeView? {
        guard isViewLoaded else { return nil }
        return (self.view as! HomeView)
    }
    
    //MARK: - Init
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        view.backgroundColor = UIColor(named: "CustomBackground")
        homeView?.viewDidLoad()
    }
    
    override func loadView() {
        let view = HomeView(frame: UIScreen.main.bounds)
        view.presenter = presenter
        self.view = view
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        homeView?.viewWillTransition()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

extension HomeVC: IHomeVC {
    func insertNewInvoice() {
        homeView?.insertNewInvoice()
    }
    
    func deleteRowInTableView(invoiceIndex: Int, billIndex: Int) {
        homeView?.deleteRowInTableView(invoiceIndex: invoiceIndex, billIndex: billIndex)
    }
    
    func refreshTableViewRow(invoiceIndex: Int, billIndex: Int) {
        homeView?.refreshTableViewByIndex(invoiceIndex: invoiceIndex, billIndex: billIndex)
    }
    
    func insertNewData(index: Int) {
        homeView?.insertNewDataInTable(index: index)
    }
    
    func showViewController(view: UIViewController) {
        self.present(view, animated: true)
    }
}
