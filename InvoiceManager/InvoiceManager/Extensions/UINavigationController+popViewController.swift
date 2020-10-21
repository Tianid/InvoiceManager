//
//  UINavigationController+popViewController.swift
//  InvoiceManager
//
//  Created by Tianid on 14.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

extension UINavigationController {
    func popViewController(animated:Bool = true, completion: (()->())?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func popViewControllerTo(controller: UIViewController, animated:Bool = true, completion: (()->())?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popToViewController(controller, animated: true)
        CATransaction.commit()
    }
}
