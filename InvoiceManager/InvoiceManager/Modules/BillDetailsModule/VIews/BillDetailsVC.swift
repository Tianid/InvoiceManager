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
    private var billDetailsView: BillDetailsView? {
        guard isViewLoaded else { return nil }
        return (self.view as! BillDetailsView)
    }
    //MARK: - Init
    //MARK: - Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func loadView() {
        let view = BillDetailsView(frame: UIScreen.main.bounds)
        view.presenter = presenter
        self.view = view
    }
    
}

extension BillDetailsVC: IBillDetailsVC {
    func dismissDetail() {
        dismiss(animated: true, completion: nil)
    }
    
    func setCategory(name: String) {
        billDetailsView?.setCategory(name: name)
    }
    
    func showBillCategoryModule(view: UIViewController) {
        present(view, animated: true)
    }
}
