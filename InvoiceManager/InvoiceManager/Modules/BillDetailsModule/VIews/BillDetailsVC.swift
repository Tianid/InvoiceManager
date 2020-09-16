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
    
    override var hidesBottomBarWhenPushed: Bool {
        get {
            return navigationController?.topViewController == self
        }
        set {
            super.hidesBottomBarWhenPushed = newValue
        }
    }
    
    private var billDetailsView: BillDetailsView? {
        guard isViewLoaded else { return nil }
        return (self.view as! BillDetailsView)
    }
    //MARK: - Init
    //MARK: - Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func loadView() {
        let view = BillDetailsView(frame: UIScreen.main.bounds)
        view.presenter = presenter
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc private func saveButtonTapped(_ sender: UIBarButtonItem) {
        billDetailsView?.saveButtonTapped()
    }
    
    @objc private func deleteButtonTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: nil, message: "You definitely want to delete the bill", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] (_) in
            self?.presenter?.deleteTapped()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in }
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .white
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveButtonTapped(_:))), animated: true)
        
        if presenter?.model != nil {
            if #available(iOS 13.0, *) {
                self.navigationItem.rightBarButtonItems?.append(UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteButtonTapped(_:))))
            } else {
                // Fallback on earlier versions
            }
        }
        
        billDetailsView?.updateDetailFields()
    }
}

extension BillDetailsVC: IBillDetailsVC {    
    func setCategory(name: String) {
        billDetailsView?.setCategory(name: name)
    }
}
