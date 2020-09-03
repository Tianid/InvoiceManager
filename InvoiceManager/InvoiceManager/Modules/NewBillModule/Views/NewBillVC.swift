//
//  NewBillVC.swift
//  InvoiceManager
//
//  Created by Tianid on 03.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class NewBillVC: UIViewController {
    //MARK: - Properties
    var presenter: INewBillPresenter?
    //MARK: - Init
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
}

extension NewBillVC: INewBillVC {
    
}
