//
//  CategorisedBillsVC.swift
//  InvoiceManager
//
//  Created by Tianid on 01.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class CategorisedBillsVC: UIViewController {
    //MARK: - Properties
    var presenter: ICategorisedBillsPresenter?
    
    private var newInvoiceView: CategorisedBillsView? {
        guard isViewLoaded else { return nil }
        return (self.view as! CategorisedBillsView)
    }
    //MARK: - Init
    //MARK: - Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        let view = CategorisedBillsView(frame: UIScreen.main.bounds)
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}

extension CategorisedBillsVC: ICategorisedBillsVC {
    
}
