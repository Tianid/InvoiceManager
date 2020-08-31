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
    
    //MARK: - Init
    //MARK: - Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

extension CategoryVC: ICategoryVC {
    
}
