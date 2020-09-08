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
        navigationController?.navigationBar.isHidden = true
    }
    
    override func loadView() {
        let view = HomeView(frame: UIScreen.main.bounds)
        view.presenter = presenter?.generateSPHomeView(view: view)
        self.view = view
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        homeView?.viewWillTransition()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        myCollection.collectionViewLayout.invalidateLayout()
        
    }
    
}

extension HomeVC: IHomeVC {

}
