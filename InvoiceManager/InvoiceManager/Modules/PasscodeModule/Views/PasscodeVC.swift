//
//  PasscodeVC.swift
//  InvoiceManager
//
//  Created by Tianid on 20.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class PasscodeVC: UIViewController {
    //MARK: - Properties
    var presenter: IPasscodePresenter?
    
    private var passcodeView: PasscodeView? {
        guard isViewLoaded else { return nil }
        return (self.view as! PasscodeView)
    }
    //MARK: - Init
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        let view = PasscodeView(frame: UIScreen.main.bounds)
        view.presenter = presenter
        self.view = view
    }
}
