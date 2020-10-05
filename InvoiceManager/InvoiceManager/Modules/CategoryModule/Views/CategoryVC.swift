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
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        definesPresentationContext = true
        categoryView?.navigationItem = navigationItem
    }
    
    override func loadView() {
        let view = CategoryView(frame: UIScreen.main.bounds)
        view.presenter = presenter
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Categories"
        self.navigationItem.largeTitleDisplayMode = .automatic
    }
}

extension CategoryVC: ICategoryVC {
    
}
