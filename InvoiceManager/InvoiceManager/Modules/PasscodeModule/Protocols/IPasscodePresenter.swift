//
//  IPasscodePresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 22.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit
import Foundation
import TOPasscodeViewController

protocol IPasscodePresenter {
    var type: TOPasscodeType { get set }
    var passcode: String { get set }
    func enterPasscodeButtonTapped(view: UIViewController)
    func didEnterCorrectCode()
    func didCancelTapped()

}
