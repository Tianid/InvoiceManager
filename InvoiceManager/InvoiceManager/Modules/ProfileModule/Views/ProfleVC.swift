//
//  ProfleVC.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    //MARK: - Properties
    var presenter: IProfilePresenter?
    //MARK: - Init
    //MARK: - Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

extension ProfileVC: IProfileVC {
    
}
