//
//  BillCategoryVC.swift
//  InvoiceManager
//
//  Created by Tianid on 10.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class BillCategoryVC: UIViewController {
    //MARK: - Properties
    var presenter: IBillCategoryPresenter?
    
    private var billDetailsView: BillCategoryView? {
        guard isViewLoaded else { return nil }
        return (self.view as! BillCategoryView)
    }
    //MARK: - Init
    //MARK: - Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
         let view = BillCategoryView(frame: UIScreen.main.bounds)
         view.presenter = presenter
         self.view = view
     }
}

extension BillCategoryVC: IBillCategoryVC {
    func dismissBillCategory(complition: (() -> ())?) {
        self.dismiss(animated: true, completion: complition)
    }
}
