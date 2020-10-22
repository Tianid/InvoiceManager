//
//  PasscodeView.swift
//  InvoiceManager
//
//  Created by Tianid on 22.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import TOPasscodeViewController

class PasscodeView: UIView {
    //MARK: - Properties
    var presenter: IPasscodePresenter?
    
    private var enterPasscodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enter Passcode", for: .normal)
        button.addTarget(self, action: #selector(enterPasscodeButtonTapped), for: .touchUpInside)
        return button
    }()
    //MARK: - Init
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Func
    
    
    private func configureViews() {
        addSubview(enterPasscodeButton)
        enterPasscodeButton.anchor(centerX: centerXAnchor, centerY: centerYAnchor)
    }
    
    @objc func enterPasscodeButtonTapped() {
        guard let presenter = presenter else { return }
        let passcodeVC: TOPasscodeViewController!
        
        if #available(iOS 13, *) {
            let style: TOPasscodeViewStyle = self.traitCollection.userInterfaceStyle == .dark ? .translucentDark : .translucentLight
            passcodeVC = TOPasscodeViewController(style: style, passcodeType: presenter.type)
        } else {
            passcodeVC = TOPasscodeViewController(style: .translucentLight, passcodeType: presenter.type)
        }
        
        passcodeVC.delegate = self
        passcodeVC.allowBiometricValidation = false
        
        presenter.enterPasscodeButtonTapped(view: passcodeVC)
    }
}

extension PasscodeView: TOPasscodeViewControllerDelegate {
    func passcodeViewController(_ passcodeViewController: TOPasscodeViewController, isCorrectCode code: String) -> Bool {
        print(#function)
        guard let presenter = presenter else { return false }
        return presenter.passcode.elementsEqual(code)
    }
    
    func didTapCancel(in passcodeViewController: TOPasscodeViewController) {
        print(#function)
        presenter?.didCancelTapped()
    }
    
    func didInputCorrectPasscode(in passcodeViewController: TOPasscodeViewController) {
        print(#function)
        presenter?.didEnterCorrectCode()
    }
}
