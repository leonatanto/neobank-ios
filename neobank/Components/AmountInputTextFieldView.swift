//
//  AmountInputTextFieldView.swift
//  neobank
//
//  Created by Leon Natanto on 17/07/24.
//

/**
 This is view that contain textField with prefix also have button for quick set value
 */

import UIKit

class AmountInputTextFieldView: UIView, UITextFieldDelegate {
    
    var onValueChange: ((String) -> Void)?
    
    private let lblPrefix: UILabel = {
        let label = UILabel()
        label.text = "Rp "
        label.textColor = UIColor.TitleColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter amount"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    var prefix: String = "Rp " {
        didSet {
            lblPrefix.text = prefix
        }
    }
    
    private let lblDescription: UILabel = {
        let label = UILabel()
        label.text = "Minimum deposito Rp100.000"
        label.textColor = UIColor.GrayColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        return label
    }()
    
    private let btnFirst: UIButton = {
        let button = UIButton()
        button.setTitle("Rp1.000.000", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.GrayColor.cgColor
        button.layer.cornerRadius = 12
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    private let btnSecond: UIButton = {
        let button = UIButton()
        button.setTitle("Rp50.000.000", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.GrayColor.cgColor
        button.layer.cornerRadius = 12
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    private let btnThird: UIButton = {
        let button = UIButton()
        button.setTitle("Rp100.000.000", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.GrayColor.cgColor
        button.layer.cornerRadius = 12
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    private let btnFourth: UIButton = {
        let button = UIButton()
        button.setTitle("Rp500.000.000", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.GrayColor.cgColor
        button.layer.cornerRadius = 12
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    // formatter to give .
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 0
        return formatter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        setupUI()
        setupConstraints()
    }
    
    private func setupUI(){
        addSubview(lblPrefix)
        addSubview(textField)
        addSubview(lblDescription)
        addSubview(btnFirst)
        addSubview(btnSecond)
        addSubview(btnThird)
        addSubview(btnFourth)
        
        lblPrefix.translatesAutoresizingMaskIntoConstraints = false
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        btnFirst.translatesAutoresizingMaskIntoConstraints = false
        btnSecond.translatesAutoresizingMaskIntoConstraints = false
        btnThird.translatesAutoresizingMaskIntoConstraints = false
        btnFourth.translatesAutoresizingMaskIntoConstraints = false
        
        lblPrefix.text = "Rp"
        lblPrefix.font = UIFont.systemFont(ofSize: 17)
        
        lblPrefix.setContentHuggingPriority(.required, for: .horizontal)
        
        // set content hugging
        lblPrefix.setContentHuggingPriority(.required, for: .horizontal)
        
        textField.delegate = self
        textField.isUserInteractionEnabled = true
        textField.borderStyle = .none
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        btnFirst.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        btnSecond.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        btnThird.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        btnFourth.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            // Prefix
            lblPrefix.leadingAnchor.constraint(equalTo: leadingAnchor),
            lblPrefix.centerYAnchor.constraint(equalTo: textField.centerYAnchor), // Align vertically with textField
            
            // Textfield
            textField.leadingAnchor.constraint(equalTo: lblPrefix.trailingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            // lblDescription
            lblDescription.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            lblDescription.leadingAnchor.constraint(equalTo: leadingAnchor),
            lblDescription.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // Quick Button
            btnFirst.topAnchor.constraint(equalTo: lblDescription.bottomAnchor, constant: 16),
            btnFirst.leadingAnchor.constraint(equalTo: leadingAnchor),
            btnSecond.topAnchor.constraint(equalTo: lblDescription.bottomAnchor, constant: 16),
            btnSecond.leadingAnchor.constraint(equalTo: btnFirst.trailingAnchor, constant: 16),
            btnThird.topAnchor.constraint(equalTo: lblDescription.bottomAnchor, constant: 16),
            btnThird.leadingAnchor.constraint(equalTo: btnSecond.trailingAnchor, constant: 16),
            btnFourth.topAnchor.constraint(equalTo: btnFirst.bottomAnchor, constant: 16),
            btnFourth.leadingAnchor.constraint(equalTo: leadingAnchor),
            btnFourth.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        
        // Remove "Rp" prefix
        let valueWithoutPrefix = title.replacingOccurrences(of: "Rp", with: "").trimmingCharacters(in: .whitespaces)
        
        textField.text = valueWithoutPrefix
        onValueChange?(valueWithoutPrefix)  // Notify value change
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            onValueChange?(text)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else {
            return true
        }
        
        let newText = currentText.replacingCharacters(in: range, with: string)
        
        if let formattedText = formatCurrencyInput(newText) {
            textField.text = formattedText
            onValueChange?(formattedText)  // Notify value change
        } else {
            textField.text = ""
            onValueChange?("")  // Notify value change
        }
        
        return false
    }
    
    private func formatCurrencyInput(_ input: String) -> String? {
        // Check if the input is empty
        if input.isEmpty {
            return nil
        }
        
        // Remove non-numeric characters
        let cleanInput = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        guard let number = Double(cleanInput) else {
            return nil
        }
        
        return numberFormatter.string(from: NSNumber(value: number))
    }
    
}
