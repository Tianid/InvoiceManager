//
//  NumericKeyboard.swift
//  InvoiceManager
//
//  Created by Tianid on 08.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class DigitButton: UIButton {
    var digit: Int = 0
    var prevColor: UIColor? = UIColor(named: "CustomColor")
    
    
    func changeColortoGray() {
        prevColor = backgroundColor
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    func cahangeColorToDefault() {
        backgroundColor = prevColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        changeColortoGray()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        cahangeColorToDefault()
    }
}

class NumericKeyboard: UIView {
    weak var target: UIKeyInput?
    var useDecimalSeparator: Bool

    var numericButtons: [DigitButton] = (0...9).map {
        let button = DigitButton(type: .custom)
        button.digit = $0
        button.setTitle("\($0)", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.setTitleColor(UIColor(named: "CustomFont"), for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = UIColor(named: "CustomColor")
        button.accessibilityTraits = [.keyboardKey]
        button.addTarget(self, action: #selector(didTapDigitButton(_:)), for: .touchUpInside)
        return button
    }

    var deleteButton: DigitButton = {
        let button = DigitButton(type: .system)
        button.setTitle("⌫", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.setTitleColor(UIColor(named: "CustomFont"), for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = UIColor(named: "CustomColor")
        button.accessibilityTraits = [.keyboardKey]
        button.accessibilityLabel = "Delete"
        button.addTarget(self, action: #selector(didTapDeleteButton(_:)), for: .touchUpInside)
        return button
    }()

    lazy var decimalButton: DigitButton = {
        let button = DigitButton(type: .system)
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        button.setTitle(decimalSeparator, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.setTitleColor(UIColor(named: "CustomFont"), for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = UIColor(named: "CustomColor")
        button.accessibilityTraits = [.keyboardKey]
        button.accessibilityLabel = decimalSeparator
        button.addTarget(self, action: #selector(didTapDecimalButton(_:)), for: .touchUpInside)
        return button
    }()

    init(target: UIKeyInput, useDecimalSeparator: Bool = false) {
        self.target = target
        self.useDecimalSeparator = useDecimalSeparator
        super.init(frame: .zero)
        configure()
        backgroundColor = UIColor(named: "CustomColor")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions

extension NumericKeyboard {
    @objc func didTapDigitButton(_ sender: DigitButton) {
        target?.insertText("\(sender.digit)")
    }

    @objc func didTapDecimalButton(_ sender: DigitButton) {
        target?.insertText(".")
    }

    @objc func didTapDeleteButton(_ sender: DigitButton) {
        target?.deleteBackward()
    }
}

// MARK: - Private initial configuration methods

private extension NumericKeyboard {
    func configure() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addButtons()
    }

    func addButtons() {
        let stackView = createStackView(axis: .vertical)
        stackView.frame = bounds
        stackView.backgroundColor = UIColor(named: "CustomColor")
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(stackView)

        for row in 0 ..< 3 {
            let subStackView = createStackView(axis: .horizontal)
            stackView.addArrangedSubview(subStackView)

            for column in 0 ..< 3 {
                subStackView.addArrangedSubview(numericButtons[row * 3 + column + 1])
            }
        }

        let subStackView = createStackView(axis: .horizontal)
        stackView.addArrangedSubview(subStackView)

        if useDecimalSeparator {
            subStackView.addArrangedSubview(decimalButton)
        } else {
            let blank = UIView()
            blank.layer.borderWidth = 0.5
            blank.layer.borderColor = UIColor.darkGray.cgColor
            subStackView.addArrangedSubview(blank)
        }

        subStackView.addArrangedSubview(numericButtons[0])
        subStackView.addArrangedSubview(deleteButton)
    }

    func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }
}
