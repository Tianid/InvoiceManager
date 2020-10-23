//
//  PasscodePresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 22.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit
import Foundation
import TOPasscodeViewController

class PasscodePresenter {
    //MARK: - Properties
    var type: TOPasscodeType
    var passcode: String
    private weak var view: IPasscodeVC?
    private var router: IRouter
    
    //MARK: - Init
    init(router: IRouter, view: IPasscodeVC, type: Int, passcode: String) {
        self.view = view
        self.router = router
        self.type = TOPasscodeType(rawValue: type)!
        self.passcode = passcode
    }
    
    //MARK: - Func
}

extension PasscodePresenter: IPasscodePresenter {
    func didCancelTapped() {
        self.view?.dismissPasscode(animated: true)
    }
    
    func enterPasscodeButtonTapped(view: UIViewController) {
        self.view?.presentViewController(view: view)
    }
    
    func didEnterCorrectCode() {
        self.view?.dismissPasscodeScreent(animated: true)
    }
}
