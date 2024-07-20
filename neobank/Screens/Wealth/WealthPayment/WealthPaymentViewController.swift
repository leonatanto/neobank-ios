//
//  WealthPaymentViewController.swift
//  neobank
//
//  Created by Leon Natanto on 18/07/24.
//

import UIKit

class WealthPaymentViewController: UIViewController, UIGestureRecognizerDelegate {
    private var expandedSections: Set<Int> = []
    private var countdownTimer: Timer?
    private var remainingTime: TimeInterval = 24 * 60 * 60 // 24 hours in second
    
    private lazy var topContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var btnBack: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.text = "Payment"
        label.textAlignment = .center
        label.textColor = UIColor.TitleColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.BackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imgBanner: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg-gold")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var viewBanner1: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.brown.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var lblBanner1: UILabel = {
        let label = UILabel()
        label.text = "Berakhir dalam 23:59:28"
        label.textAlignment = .center
        label.textColor = UIColor.brown
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lblBanner2: UILabel = {
        let label = UILabel()
        label.text = "Rp100.000"
        label.textAlignment = .center
        label.textColor = UIColor.brown
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lblBanner3: UILabel = {
        let label = UILabel()
        label.text = "Transaksimu aman dan terjaga"
        label.textAlignment = .center
        label.textColor = UIColor.brown
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var paymentCard: PaymentMethodCardView = {
        let view = PaymentMethodCardView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.setCard(savings: "Tabungan Reguler (4952)", balance: "100.000")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tvPayment: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PaymentMethodTableViewCell.self, forCellReuseIdentifier: "PaymentMethodTableViewCell")
        tableView.register(DescriptionPaymentTableViewCell.self, forCellReuseIdentifier: "DescriptionPaymentTableViewCell")
        return tableView
    }()
    
    private var viewModel: WealthPaymentViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = WealthPaymentViewModel()
        setupNavigationBar()
        setupUI()
        startCountdown()
    }
    
    private func setupNavigationBar() {
        if let navigationController = self.navigationController {
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
            navigationController.interactivePopGestureRecognizer?.delegate = self
        }
        
        navigationItem.hidesBackButton = true
    }
    
    private func startCountdown() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    @objc private func updateCountdown() {
        if remainingTime > 0 {
            remainingTime -= 1 // minus by 1
            lblBanner1.text = formatTime(remainingTime)
        } else {
            countdownTimer?.invalidate()
            countdownTimer = nil
        }
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String("Berakhir dalam \(hours):\(minutes):\(seconds)")
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(topContainer)
        view.addSubview(bottomContainer)
        view.addSubview(btnBack)
        view.addSubview(lblTitle)
        
        viewBanner1.addSubview(lblBanner1)
        bottomContainer.addSubview(imgBanner)
        bottomContainer.addSubview(viewBanner1)
        bottomContainer.addSubview(lblBanner2)
        bottomContainer.addSubview(lblBanner3)
        bottomContainer.addSubview(paymentCard)
        bottomContainer.addSubview(tvPayment)
        
        NSLayoutConstraint.activate([
            // Top container constraints
            topContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Back button constraints
            btnBack.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 16),
            btnBack.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 16),
            btnBack.widthAnchor.constraint(equalToConstant: 20),
            btnBack.heightAnchor.constraint(equalToConstant: 20),
            btnBack.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: -16),
            
            // Title constraints
            lblTitle.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            lblTitle.centerYAnchor.constraint(equalTo: btnBack.centerYAnchor),
            
            // Bottom container constraints
            bottomContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            bottomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Banner image view constraints
            imgBanner.topAnchor.constraint(equalTo: bottomContainer.topAnchor),
            imgBanner.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor),
            imgBanner.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor),
            imgBanner.heightAnchor.constraint(equalToConstant: 150),
            
            // Container Banner 1
            viewBanner1.topAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: 16),
            viewBanner1.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
            viewBanner1.leadingAnchor.constraint(greaterThanOrEqualTo: bottomContainer.leadingAnchor, constant: 16),
            viewBanner1.trailingAnchor.constraint(lessThanOrEqualTo: bottomContainer.trailingAnchor, constant: -16),
            viewBanner1.heightAnchor.constraint(equalToConstant: 40),
            
            // First Label constraints
            lblBanner1.topAnchor.constraint(equalTo: viewBanner1.topAnchor, constant: 8),
            lblBanner1.bottomAnchor.constraint(equalTo: viewBanner1.bottomAnchor, constant: -8),
            lblBanner1.leadingAnchor.constraint(equalTo: viewBanner1.leadingAnchor, constant: 8),
            lblBanner1.trailingAnchor.constraint(equalTo: viewBanner1.trailingAnchor, constant: -8),
            
            // Second Label constraints
            lblBanner2.topAnchor.constraint(equalTo: viewBanner1.bottomAnchor, constant: 8),
            lblBanner2.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
            
            // Third Label constraints
            lblBanner3.topAnchor.constraint(equalTo: lblBanner2.bottomAnchor, constant: 8),
            lblBanner3.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
            
            // Payment card constraints
            paymentCard.topAnchor.constraint(equalTo: imgBanner.bottomAnchor, constant: 16),
            paymentCard.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant: 16),
            paymentCard.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant: -16),
            paymentCard.heightAnchor.constraint(equalToConstant: 100),
            
            // Tv constraints
            tvPayment.topAnchor.constraint(equalTo: paymentCard.bottomAnchor, constant: 16),
            tvPayment.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor),
            tvPayment.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor),
            tvPayment.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor)
        ])
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}


extension  WealthPaymentViewController:  UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expandedSections.contains(section) ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodTableViewCell", for: indexPath) as! PaymentMethodTableViewCell
            cell.configure(with: section.title, image: section.image, isExpanded: expandedSections.contains(indexPath.section))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionPaymentTableViewCell", for: indexPath) as! DescriptionPaymentTableViewCell
            cell.configure(with: section.description)
            return cell
        }
    }
}

extension WealthPaymentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if expandedSections.contains(indexPath.section) {
                expandedSections.remove(indexPath.section)
            } else {
                expandedSections.insert(indexPath.section)
            }
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        }
    }
}
