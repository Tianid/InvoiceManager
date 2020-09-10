//
//  IBillDetailsVC.swift
//  InvoiceManager
//
//  Created by Tianid on 08.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

protocol IBillDetailsVC: class {
    func showBillCategoryModule(view: UIViewController)
    func setCategory(name: String)
    func dismissDetail()
}
