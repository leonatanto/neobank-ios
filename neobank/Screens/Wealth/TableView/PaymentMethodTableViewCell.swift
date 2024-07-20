//
//  PaymentMethodTableViewCell.swift
//  neobank
//
//  Created by Leon Natanto on 20/07/24.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {
    private let lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.TitleColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let imgArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var imgProvider: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imgProvider)
        contentView.addSubview(lblTitle)
        contentView.addSubview(imgArrow)
        
        NSLayoutConstraint.activate([
            imgProvider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imgProvider.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgProvider.widthAnchor.constraint(equalToConstant: 20),
            imgProvider.heightAnchor.constraint(equalToConstant: 20),
            
            lblTitle.leadingAnchor.constraint(equalTo: imgProvider.trailingAnchor, constant: 16),
            lblTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            imgArrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imgArrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgArrow.widthAnchor.constraint(equalToConstant: 20),
            imgArrow.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(with title: String, image: String, isExpanded: Bool) {
        lblTitle.text = title
        let arrowImage = isExpanded ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.up")
        
        let providerImage = UIImage(named: image)
        imgArrow.image = arrowImage
        imgProvider.image = providerImage
    }
}
