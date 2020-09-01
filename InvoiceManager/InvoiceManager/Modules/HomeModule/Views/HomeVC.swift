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
    private var homeView: HomeView? {
        guard isViewLoaded else { return nil }
        return (self.view as! HomeView)
    }
    
    //MARK: - Init
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
    
    override func loadView() {
        self.view = HomeView(frame: UIScreen.main.bounds)
    }
}

extension HomeVC: IHomeVC {
    
}
