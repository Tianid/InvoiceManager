//
//  PasscodeSettingsVC.swift
//  InvoiceManager
//
//  Created by Tianid on 20.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class PasscodeSettingsVC: UIViewController {
    //MARK: - Properties
    var presenter: IPasscodeSettingsPresenter?
    
    
    override var hidesBottomBarWhenPushed: Bool {
        get {
            return navigationController?.topViewController == self
        }
        set {
            super.hidesBottomBarWhenPushed = newValue
        }
    }
    
    private var passcodeView: PasscodeSettingsView? {
        guard isViewLoaded else { return nil }
        return (self.view as! PasscodeSettingsView)
    }
    
    //MARK: - Init
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CustomBackground")
        navigationItem.largeTitleDisplayMode = .never
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func loadView() {
        let view = PasscodeSettingsView(frame: UIScreen.main.bounds)
        view.presenter = presenter
        self.view = view
    }
}

extension PasscodeSettingsVC: IPasscodeSettingsVC {
    func dissmisToPasscodeSettings(isPasscodeSet: Bool) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: PasscodeSettingsVC.self) {
           
                self.navigationController?.popViewControllerTo(controller: controller, animated: true, completion: {
                    self.passcodeView?.changeViews(isPasscodeSet: isPasscodeSet)
                })
                break
            }
        }
    }
    
    func presentPasscodeSettings(view: UIViewController) {
        self.navigationController?.pushViewController(view, animated: true)
    }
}
