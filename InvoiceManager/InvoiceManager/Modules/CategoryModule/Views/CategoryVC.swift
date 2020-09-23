//
//  CategoryVC.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
    //MARK: - Properties
    var presenter: ICategoryPresenter?
    
    private var categoryView: CategoryView? {
        guard isViewLoaded else { return nil }
        return (self.view as! CategoryView)
    }
    
    //MARK: - Init
    //MARK: - Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    override func loadView() {
        let view = CategoryView(frame: UIScreen.main.bounds)
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

extension CategoryVC: ICategoryVC {
    
}
