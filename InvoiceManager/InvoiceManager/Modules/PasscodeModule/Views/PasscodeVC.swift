//
//  PasscodeVC.swift
//  InvoiceManager
//
//  Created by Tianid on 22.10.2020.
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
        view.backgroundColor = .systemPink
        
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        let view = PasscodeView(frame: UIScreen.main.bounds)
        view.presenter = presenter
        self.view = view
    }
    
    
    private func dismissViewController(animated: Bool, complition: (() -> ())?) {
        dismiss(animated: animated, completion: {
            complition?()
        })
    }
}

extension PasscodeVC: IPasscodeVC {
    func presentViewController(view: UIViewController) {
        present(view, animated: true)
    }
    
    
    func dismissPasscode(animated: Bool) {
        dismissViewController(animated: animated, complition: nil)
    }
    
    func dismissPasscodeScreent(animated: Bool) {
        dismissViewController(animated: animated, complition: { [weak self] in
            self?.dismissViewController(animated: animated, complition: nil)
        })
    }
}



