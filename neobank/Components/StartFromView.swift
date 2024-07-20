//
//  StartFromView.swift
//  neobank
//
//  Created by Leon Natanto on 16/07/24.
//

import UIKit

class StartFromView: UIView {
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Rp100 rb"
        label.textColor = UIColor.TitleColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Mulai dari"
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
            topLabel.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor, constant: 0),
            
            bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setText(_ text: String) {
        topLabel.text = "\(text)"
    }
}
