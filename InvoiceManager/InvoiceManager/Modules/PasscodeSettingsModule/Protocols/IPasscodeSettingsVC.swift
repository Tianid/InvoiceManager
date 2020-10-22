//
//  IPasscodeSettingsVC.swift
//  InvoiceManager
//
//  Created by Tianid on 20.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import UIKit

protocol IPasscodeSettingsVC: class {
    func presentPasscodeSettings(view: UIViewController)
    func dismissToPasscodeSettings(isPasscodeSet: Bool)
}
