//
//  WealthTableViewCell.swift
//  neobank
//
//  Created by Leon Natanto on 16/07/24.
//

import UIKit

protocol WealthTableViewCellDelegate: AnyObject {
    // for navigate to detail
    func onPressOpen(at indexPath: IndexPath)
}

class WealthTableViewCell: UITableViewCell {
    static let identifier = "WealthTableViewCell"
    var indexPath: IndexPath?
    weak var delegate: WealthTableViewCellDelegate?
    
    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor.TitleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let popularLabel: UILabel = {
        let label = UILabel()
        label.text = "Populer"
        label.textColor = .white
        label.backgroundColor = .red
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.TitleColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let interestView: InterestView = {
        let view = InterestView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let startFromView: StartFromView = {
        let view = StartFromView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let commonButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buka", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.TintColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let thirdSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Third"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.backgroundColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    @objc private func onPressOpenButton() {
        guard let indexPath = indexPath else { return }
        delegate?.onPressOpen(at: indexPath)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(topView)
        contentView.addSubview(bottomView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(popularLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(interestView)
        horizontalStackView.addArrangedSubview(startFromView)
        horizontalStackView.addArrangedSubview(buttonContainerView)
        buttonContainerView.addSubview(commonButton)
        commonButton.addTarget(self, action: #selector(onPressOpenButton), for: .touchUpInside)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) error")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Top Container
            topView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            topView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -8),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            
            // Popular label
            popularLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            popularLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 8),
            popularLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            popularLabel.widthAnchor.constraint(equalToConstant: 80),
            
            // Description label constraints
            descriptionLabel.topAnchor.constraint(equalTo: popularLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8),
            
            // Separator view constraints
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            // Horizontal stack view constraints
            horizontalStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 0),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            horizontalStackView.heightAnchor.constraint(equalToConstant: 50),
            
            // Container button
            commonButton.topAnchor.constraint(equalTo: buttonContainerView.topAnchor, constant: 2),
            commonButton.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor, constant: 12),
            commonButton.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor, constant: -12),
            // commonButton.bottomAnchor.constraint(equalTo: buttonContainerView.bottomAnchor, constant: -12),
        ])
    }
    
    func configure(with title: String, description: String, isPopular: Bool, startingAmount: String, rate: Int) {
        titleLabel.text = title
        descriptionLabel.text = description
        interestView.setText(String(rate))
        startFromView.setText("Rp\(startingAmount)")
        popularLabel.isHidden = !isPopular
    }
}
