//
//  CATransition+FromBottom.swift
//  InvoiceManager
//
//  Created by Tianid on 11.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

extension CATransition {
    func segueFromBottom() -> CATransition {
        self.duration = 0.5 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromTop
        return self
    }
    
    func segueFromTop() -> CATransition {
        self.duration = 0.5 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromBottom
        return self
    }
}
