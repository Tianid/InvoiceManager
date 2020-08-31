//
//  HomeVC.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    //MARK: - Properties
    var presenter: IHomePresenter?
    
    //MARK: - Init
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}

extension HomeVC: IHomeVC {
    
}
