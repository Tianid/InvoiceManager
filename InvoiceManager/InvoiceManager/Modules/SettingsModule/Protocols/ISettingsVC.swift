//
//  ISettingsVC.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

protocol ISettingsVC: class {
    func presentVC(view: UIViewController)
    func showDocumentPicker()
}
