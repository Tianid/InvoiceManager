//
//  PresentationController.swift
//  InvoiceManager
//
//  Created by Tianid on 09.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    //MARK: - Properties
    
    var driver: TransitionDriver!
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        let halfHeight = bounds.height / 2
        return CGRect(x: 0, y: halfHeight, width: bounds.width, height: halfHeight)
    }
    
    //MARK: - Func
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.addSubview(presentedView!)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        if completed {
            driver.direction = .dismiss
        }
    }
}
