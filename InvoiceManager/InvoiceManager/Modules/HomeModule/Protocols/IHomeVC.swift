//
//  IHomeVC.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

protocol IHomeVC: class {
    func showBillDetail(view: UIViewController)
    func insertNewData(index: Int)
    func refreshTableViewRow(invoiceIndex: Int, billIndex: Int)
}
