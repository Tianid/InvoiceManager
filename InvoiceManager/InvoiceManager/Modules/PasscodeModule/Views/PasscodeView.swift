//
//  PasscodeView.swift
//  InvoiceManager
//
//  Created by Tianid on 22.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import TOPasscodeViewController
import LocalAuthentication

class PasscodeView: UIView {
    //MARK: - Properties
    var presenter: IPasscodePresenter?
    private var authContext: LAContext = .init()
    private var biometricAvailable: Bool = false
    private var faceIDAvailable: Bool = false
    
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
        
        self.biometricAvailable = authContext.canEvaluatePolicy( .deviceOwnerAuthenticationWithBiometrics, error: nil)
        self.faceIDAvailable = (self.authContext.biometryType == .faceID)
        
        passcodeVC.delegate = self
        passcodeVC.allowBiometricValidation = self.biometricAvailable
        passcodeVC.biometryType = self.faceIDAvailable ? .faceID : .touchID
        
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
    
    func didPerformBiometricValidationRequest(in passcodeViewController: TOPasscodeViewController) {
        print(#function)
        
        let reason = "Touch ID to continue using this app"
        
        let reply =  { [weak self] (success: Bool, error: Error?) in
            if success {
                // Touch ID validation was successful
                // (Use this to dismiss the passcode controller and display the protected content)
                DispatchQueue.main.async {
                    // Create a new Touch ID context for next time
                    self?.authContext.invalidate()
                    self?.authContext = .init()
                    
                    // Dismiss the passcode controller
                    self?.presenter?.didEnterCorrectCode()
                }
                return
            }
            
            // Actual UI changes need to be made on the main queue
            DispatchQueue.main.async {
                passcodeViewController.setContentHidden(false, animated: true)
            }
            
            if let nsError = error as NSError? {
                // The user hit 'Enter Password'. This should probably do nothing
                // but make sure the passcode controller is visible.
                if (nsError.code == kLAErrorUserFallback ) {
                    NSLog("User tapped 'Enter Password'");
                    return
                }
                
                // The user hit the 'Cancel' button in the Touch ID dialog.
                // At this point, you could either simply return the user to the passcode controller,
                // or dismiss the protected content and go back to a safer point in your app (Like the login page).
                if (nsError.code == kLAErrorUserCancel) {
                    NSLog("User tapped cancel.");
                    return;
                }
                
                // There shouldn't be any other potential errors, but just in case
                NSLog("%@", nsError.localizedDescription);
            }
            
        }
        passcodeViewController.setContentHidden(true, animated: true)
        authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: reply)
    }
}
