//
//  IPasscodeVC.swift
//  InvoiceManager
//
//  Created by Tianid on 22.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit
import Foundation

protocol IPasscodeVC: class {
    func presentViewController(view: UIViewController)
    func dismissPasscode(animated: Bool)
    func dismissPasscodeScreent(animated: Bool)
}
