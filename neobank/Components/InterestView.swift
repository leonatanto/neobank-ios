//
//  InterestView.swift
//  neobank
//
//  Created by Leon Natanto on 16/07/24.
//
//
//  InterestView.swift
//  neobank
//
//  Created by Leon Natanto on 16/07/24.
//

import UIKit

class InterestView: UIView {
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Bunga"
        label.textColor = UIColor.GrayColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(topLabel)
        addSubview(bottomLabel)
        
        NSLayoutConstraint.activate([
            topLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            topLabel.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor, constant: -2),
            bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        updateInterestText("6")
    }
    
    func setText(_ text: String) {
        updateInterestText(text)
    }
    
    private func updateInterestText(_ text: String) {
        let interestText = "\(text)%"
        let suffixText = " p.a"
        let fullText = interestText + suffixText
        let attributedText = NSMutableAttributedString(string: fullText)
        
        // value percent
        let bigFontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.GrowthColor
        ]
        
        // p.a
        let smallFontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.GrowthColor
        ]
        
        // join value + p.a
        attributedText.addAttributes(bigFontAttributes, range: NSRange(location: 0, length: interestText.count))
        attributedText.addAttributes(smallFontAttributes, range: NSRange(location: interestText.count, length: suffixText.count))
        
        topLabel.attributedText = attributedText
    }
}
