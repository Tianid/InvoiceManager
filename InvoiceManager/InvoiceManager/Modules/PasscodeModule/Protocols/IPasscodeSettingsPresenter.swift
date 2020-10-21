//
//  IPasscodeSettingsPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 20.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import UIKit
import TOPasscodeViewController

protocol IPasscodeSettingsPresenter: class {
    var isPasscodeSet: Bool { get set }
    var passcode: String? { get set }
    var type: TOPasscodeType { get set }
    
    func turnOnOffPasscodeButtonPressed(view: UIViewController)
    func didChangeToNewPasscode(passcode: String, type: TOPasscodeType)
    func forceDismiss()
}
