//
//  CardView.swift
//  InvoiceManager
//
//  Created by Tianid on 02.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class CardView: UIView {
    //MARK: - Properties
    @IBInspectable var cornerRadius: CGFloat = 10
    
    @IBInspectable var shadowOffsetWidth: Int = 5
    @IBInspectable var shadowOffsetHeight: Int = 5
    @IBInspectable var shadowColor: UIColor? = .black
    @IBInspectable var shadowOpacity: Float = 0.7
    
    //MARK: - Func
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        //        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOffset = .zero
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}
