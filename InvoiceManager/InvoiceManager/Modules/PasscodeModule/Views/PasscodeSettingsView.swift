//
//  PasscodeSettingsView.swift
//  InvoiceManager
//
//  Created by Tianid on 20.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import TOPasscodeViewController

class PasscodeSettingsView: UIView {
    //MARK: - Properties
    var presenter: IPasscodeSettingsPresenter? {
        didSet {
            configureViews(isPasscodeSet: presenter?.isPasscodeSet ?? false )
        }
    }
    private var noteLabel: UILabel = {
        let label = UILabel()
        label.text = "Note: If you forget the passcode, you'll need to delete and reinstall the app. All data will be lost."
        label.numberOfLines = 0
        return label
    }()
    
    private var turnOnOffPasscodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(turnOnOffPasscodeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private var changePassword: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Passcode", for: .normal)
        button.addTarget(self, action: #selector(changePasswordButtonPresesed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Func    
    func changeViews(isPasscodeSet: Bool) {
        removeAllFromSuperView()
        configureViews(isPasscodeSet: isPasscodeSet)
    }
    
    private func configureViews(isPasscodeSet: Bool) {
        
        addSubview(turnOnOffPasscodeButton)
        addSubview(changePassword)
        addSubview(noteLabel)
        turnOnOffPasscodeButton.anchor(centerX: centerXAnchor,
                                       centerY: centerYAnchor)
        
        if isPasscodeSet {
            turnOnOffPasscodeButton.setTitle("Turn Passcode off", for: .normal)
            setContstainsInOrder(view: turnOnOffPasscodeButton, secondView: changePassword)
            setContstainsInOrder(view: changePassword, secondView: noteLabel)
        } else {
            turnOnOffPasscodeButton.setTitle("Turn Passcode on", for: .normal)
            setContstainsInOrder(view: turnOnOffPasscodeButton, secondView: noteLabel)
        }
    }
    
    private func setContstainsInOrder(view: UIView, secondView: UIView) {
        secondView.anchor(top: view.bottomAnchor,
                          leading: leadingAnchor,
                          trailing: trailingAnchor,
                          padding: UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5))
    }
    
    private func removeAllFromSuperView() {
        turnOnOffPasscodeButton.removeFromSuperview()
        changePassword.removeFromSuperview()
        noteLabel.removeFromSuperview()
    }
    
    private func preparePasscodeSettings(presenter: IPasscodeSettingsPresenter) {
        let _view = TOPasscodeSettingsViewController(style: .light)
        _view.hidesBottomBarWhenPushed = true
        
        _view.delegate = self
        if #available(iOS 13, *) {
            _view.style = self.traitCollection.userInterfaceStyle == .dark ? .dark : .light
        }
        _view.requireCurrentPasscode = presenter.isPasscodeSet
        _view.setPasscodeType(presenter.type, animated: true)
        
        presenter.turnOnOffPasscodeButtonPressed(view: _view)
    }
    
    @objc private func turnOnOffPasscodeButtonPressed() {
        guard let presenter = presenter else { return }
        
        if presenter.isPasscodeSet {
            
            let userDefaults = UserDefaults.standard
            
            userDefaults.set(false, forKey: requireCurrentPasscodeConst)
            let _ = SecurityService.deleteRecordInKeychain(for: keychainAccountConst)
            
            presenter.isPasscodeSet = false
            changeViews(isPasscodeSet: false)
            return
        }
        preparePasscodeSettings(presenter: presenter)
    }
    
    @objc private func changePasswordButtonPresesed() {
        guard let presenter = presenter else { return }
        preparePasscodeSettings(presenter: presenter)
    }
}

extension PasscodeSettingsView: TOPasscodeViewControllerDelegate {
    func passcodeViewController(_ passcodeViewController: TOPasscodeViewController, isCorrectCode code: String) -> Bool {
        print(code)
        return true
    }
    
    func didTapCancel(in passcodeViewController: TOPasscodeViewController) {
        print(#function)
    }
    
    func didInputCorrectPasscode(in passcodeViewController: TOPasscodeViewController) {
        print(#function)
    }
    
    
}

extension PasscodeSettingsView: TOPasscodeSettingsViewControllerDelegate {
    func passcodeSettingsViewController(_ passcodeSettingsViewController: TOPasscodeSettingsViewController, didAttemptCurrentPasscode passcode: String) -> Bool {
        print(#function)
        guard let presenter = presenter else { return false }
        guard let myPasscode = presenter.passcode else { return false }
        
        if passcodeSettingsViewController.failedPasscodeAttemptCount >= 5 && !myPasscode.elementsEqual(passcode) {
            presenter.forceDismiss()
            return false
        }
        
        return myPasscode.elementsEqual(passcode)
    }
    
    func passcodeSettingsViewController(_ passcodeSettingsViewController: TOPasscodeSettingsViewController, didChangeToNewPasscode passcode: String, of type: TOPasscodeType) {
        print(#function)
        presenter?.didChangeToNewPasscode(passcode: passcode, type: type)
    }
}
