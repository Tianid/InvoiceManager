//
//  PasscodeSettingsPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 20.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import UIKit
import TOPasscodeViewController

class PasscodeSettingsPresenter {
    var isPasscodeSet: Bool {
        didSet {
            passcode = isPasscodeSet ? passcode : nil
        }
    }
    var passcode: String?
    var type: TOPasscodeType
    
    private var router: IRouter
    private weak var view: IPasscodeSettingsVC?
    
    init(router: IRouter, view: IPasscodeSettingsVC, isPasscodeSet: Bool = false, passcode: String?, type: Int) {
        self.router = router
        self.view = view
        self.isPasscodeSet = isPasscodeSet
        self.passcode = passcode
        self.type = TOPasscodeType(rawValue: type)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PasscodeSettingsPresenter: IPasscodeSettingsPresenter {
    func forceDismiss() {
        view?.dissmisToPasscodeSettings(isPasscodeSet: true)
    }
    
    
    func didChangeToNewPasscode(passcode: String, type: TOPasscodeType) {
        self.isPasscodeSet = true
        self.passcode = passcode
        self.type = type
        
        //SOME CODE WITH KEYCHAIN
        let userDefaults = UserDefaults.standard
        userDefaults.set(type.rawValue, forKey: passcodeTypeConst)
        userDefaults.set(true, forKey: requireCurrentPasscodeConst)
        let dict = SecurityService.selectRecordFromKeychaint(for: keychainAccountConst)
        if dict == nil {
            let _ = SecurityService.saveRecordIntoKeychain(data: [keychainPasscodeConst: passcode], for: keychainAccountConst)
        } else {
            let _ = SecurityService.updateRecordInKeychain(data: [keychainPasscodeConst: passcode], for: keychainAccountConst)
        }
        
        view?.dissmisToPasscodeSettings(isPasscodeSet: isPasscodeSet)
    }
    
    func turnOnOffPasscodeButtonPressed(view: UIViewController) {
        self.view?.presentPasscodeSettings(view: view)
        
    }
}
