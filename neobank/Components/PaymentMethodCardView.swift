//
//  PaymentMethodCardView.swift
//  neobank
//
//  Created by Leon Natanto on 18/07/24.
//

import UIKit

class PaymentMethodCardView: UIView {
    
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.GrayColor
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Metode Pembayaran"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lblRecommendation: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.TintColor
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Rekomendasi"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewLblRecommendation: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.TintColor.cgColor
        view.layer.backgroundColor = UIColor.LightTintColor.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var lblSavings: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.TitleColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lblActiveBalance: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.GrayColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var btnPay: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Bayar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.TintColor
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(lblTitle)
        addSubview(viewLblRecommendation)
        addSubview(lblRecommendation)
        addSubview(lblSavings)
        addSubview(lblActiveBalance)
        addSubview(btnPay)
        viewLblRecommendation.addSubview(lblRecommendation)
        
        lblTitle.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        viewLblRecommendation.setContentHuggingPriority(.defaultLow, for: .horizontal)
            
        
        NSLayoutConstraint.activate([
            // Title Label Constraints
            lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lblTitle.trailingAnchor.constraint(equalTo: viewLblRecommendation.leadingAnchor, constant: -8),
            
            // Recommendation Constraints
            viewLblRecommendation.centerYAnchor.constraint(equalTo: lblTitle.centerYAnchor),
            viewLblRecommendation.leadingAnchor.constraint(equalTo: lblTitle.trailingAnchor, constant: 0),
            
            lblRecommendation.topAnchor.constraint(equalTo: viewLblRecommendation.topAnchor, constant: 4),
            lblRecommendation.leadingAnchor.constraint(equalTo: viewLblRecommendation.leadingAnchor, constant: 8),
            lblRecommendation.trailingAnchor.constraint(equalTo: viewLblRecommendation.trailingAnchor, constant: -8),
            lblRecommendation.bottomAnchor.constraint(equalTo: viewLblRecommendation.bottomAnchor, constant: -4),
            
            // Detail Label Constraints
            lblSavings.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 12),
            lblSavings.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor),
            lblSavings.trailingAnchor.constraint(equalTo: btnPay.leadingAnchor, constant: -8),
            
            // Status Label Constraints
            lblActiveBalance.topAnchor.constraint(equalTo: lblSavings.bottomAnchor, constant: 8),
            lblActiveBalance.leadingAnchor.constraint(equalTo: lblSavings.leadingAnchor),
            lblActiveBalance.trailingAnchor.constraint(equalTo: lblSavings.trailingAnchor),
            
            // Action Button Constraints
            btnPay.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            btnPay.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            btnPay.widthAnchor.constraint(equalToConstant: 60),
            btnPay.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
    }
    
    func setCard(savings: String, balance: String) {
        lblSavings.text = savings
        lblActiveBalance.text = "Saldo aktif: Rp\(balance)"
    }
}
