//
//  BillDetailsVC.swift
//  InvoiceManager
//
//  Created by Tianid on 08.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class BillDetailsVC: UIViewController {
    //MARK: - Properties
    var presenter: IBillDetailsPresenter?
    
    override var hidesBottomBarWhenPushed: Bool {
        get {
            return navigationController?.topViewController == self
        }
        set {
            super.hidesBottomBarWhenPushed = newValue
        }
    }
    
    private let billDetailsPresentingType: DetailsVCPresentingType
    private var billDetailsView: BillDetailsView? {
        guard isViewLoaded else { return nil }
        return (self.view as! BillDetailsView)
    }
    //MARK: - Init
    
    init(billDetailsPresentingType: DetailsVCPresentingType) {
        self.billDetailsPresentingType = billDetailsPresentingType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func loadView() {
        let view = BillDetailsView(frame: UIScreen.main.bounds)
        view.presenter = presenter
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc private func saveButtonTapped(_ sender: UIBarButtonItem) {
        billDetailsView?.saveButtonTapped()
    }
    
    private func configureViewController() {
//        view.backgroundColor = .white
        view.backgroundColor = UIColor(named: "CustomBackground")
        
        if billDetailsPresentingType == .edit {
            self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped(_:))), animated: true)
        }
        
        billDetailsView?.updateDetailFields()
        billDetailsView?.setupBillDetailsPresentingType(type: billDetailsPresentingType)
    }
}

extension BillDetailsVC: IBillDetailsVC {    
    func setCategory(name: String) {
        billDetailsView?.setCategory(name: name)
    }
}
