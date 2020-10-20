//
//  PasscodeView.swift
//  InvoiceManager
//
//  Created by Tianid on 20.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class PasscodeView: UIView {
    //MARK: - Properties
    var presenter: IPasscodePresenter?

    
    private var noteLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private var turnOnOffPasscodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.text = "Test button"
        return button
    }()
    
    //MARK: - Init
    //MARK: - Func

}
