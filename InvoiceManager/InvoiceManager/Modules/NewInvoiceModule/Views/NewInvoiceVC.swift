//
//  NewInvoiceVC.swift
//  InvoiceManager
//
//  Created by Tianid on 16.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class NewInvoiceVC: UIViewController {
    //MARK: - Properties
    var presenter: INewInvoicePresenter?
    
    override var hidesBottomBarWhenPushed: Bool {
        get {
            return navigationController?.topViewController == self
        }
        set {
            super.hidesBottomBarWhenPushed = newValue
        }
    }
    
    private var newInvoiceView: NewInvoiceView? {
        guard isViewLoaded else { return nil }
        return (self.view as! NewInvoiceView)
    }
    //MARK: - Init
    //MARK: - Func

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveButtonTapped(_:))), animated: true)
    }
    
    override func loadView() {
        let view = NewInvoiceView(frame: UIScreen.main.bounds)
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc private func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let data = newInvoiceView?.getUIData() else { return }
        presenter?.saveNewInvoice(data: data)
    }
    
}

extension NewInvoiceVC: INewInvoiceVC {
    
}
