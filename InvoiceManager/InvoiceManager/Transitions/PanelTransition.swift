//
//  PanelTransition.swift
//  InvoiceManager
//
//  Created by Tianid on 09.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class PanelTransition: NSObject ,UIViewControllerTransitioningDelegate {
    //MARK: - Properties
    
    private let driver = TransitionDriver()
    
    //MARK: - Func
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        driver.link(to: presented)
        let presentationController = DimmPresentationController(presentedViewController: presented, presenting: presenting ?? source)
        presentationController.driver = driver
        
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
}
