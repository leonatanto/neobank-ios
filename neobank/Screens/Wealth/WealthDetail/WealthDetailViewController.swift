//
//  WealthDetailViewController.swift
//  neobank
//
//  Created by Leon Natanto on 17/07/24.
//

import UIKit

class WealthDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    private var interestSuffix: String = " p.a"
    var interest: Double = 7.5
    var detailTitle = "Deposito FLEXI 1 bulan"
    private var selectedRollover: Int = 0
    private var amount = ""
    
    /// ======= REMARK TOP SECTION =======
    ///
    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let btnBack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "back")
        button.setImage(image, for: .normal)
        
        return button
    }()
    
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = detailTitle
        label.textColor = UIColor.TitleColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var lblInterest: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let interestText = "\(interest) %"
        let fullText = interestText + interestSuffix
        let attributedText = NSMutableAttributedString(string: fullText)
        
        // For value
        let bigFontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: UIColor.GrowthColor
        ]
        
        // For p.a
        let smallFontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.GrowthColor
        ]
        
        // join
        attributedText.addAttributes(bigFontAttributes, range: NSRange(location: 0, length: interestText.count))
        attributedText.addAttributes(smallFontAttributes, range: NSRange(location: interestText.count, length: interestSuffix.count))
        
        label.attributedText = attributedText
        
        return label
    }()
    
    private let lblTotalMonth: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1 bulan"
        label.textColor = UIColor.TitleColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private let lblDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.GrayColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "Suku bunga saat in iakan digitung berdasarkan `suku bunga dasar + suku bunga tambahanan` dan suku bunga saat roll-over akan dihitung berdasarkan suku bunga yang berlaku di tanggal roll-over."
        return label
    }()
    
    /// ======= REMARK BOTTOM SECTION =======
    ///
    
    private let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lblTotalDeposit: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Masukkan jumlah deposito"
        label.textColor = UIColor.TitleColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let tfAmount: AmountInputTextFieldView = {
        let view = AmountInputTextFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dashedLineView: UIView = {
        let view = UIView()
        let dashedLayer = CAShapeLayer()
        view.translatesAutoresizingMaskIntoConstraints = false
        dashedLayer.strokeColor = UIColor.lightGray.cgColor
        dashedLayer.lineWidth = 1
        dashedLayer.lineDashPattern = [4, 2]
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 350, y: 0))
        dashedLayer.path = path.cgPath
        view.layer.addSublayer(dashedLayer)
        return view
    }()
    
    private let lblDueDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Jatuh Tempo"
        label.textColor = UIColor.LightGrayColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private let lblDueDateValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "28/05/2024"
        label.textAlignment = .left
        label.textColor = UIColor.SubtitleColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private let lblInterestEstimation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Estimasi bunga"
        label.textColor = UIColor.GrayColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let lblInterestValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rp0.00"
        label.textColor = UIColor.TitleColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    /// ======= REMARK ROLLOVER SECTION =======
    ///
    
    private let rolloverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lblRollover: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Opsi Rollover"
        label.textColor = UIColor.GrayColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let lblRolloverValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pokok"
        label.textColor = UIColor.TitleColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let btnRollover: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "next")
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let btnOpenNow: UIButton = {
        let button = UIButton()
        button.setTitle("Buka Sekarang", for: .normal)
        button.setTitleColor(UIColor.TitleColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.layer.backgroundColor = UIColor.TintColor.cgColor
        button.layer.cornerRadius = 16
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var btnTnc: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Create attributed string
        let fullText = "Saya telah membaca dan menyetujui «FLEXI TnC»"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Add underline and make it clickable
        let range = (fullText as NSString).range(of: "«FLEXI TnC»")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: range)
        
        // Set attributed text to button
        button.setAttributedTitle(attributedString, for: .normal)
        
        // Set font and text color
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.setTitleColor(UIColor.SubtitleColor, for: .normal)
        
        // Target and action for button tap
        button.addTarget(self, action: #selector(onNavigateToWebview), for: .touchUpInside)
        return button
    }()
    
    private lazy var btnTncImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "checklist")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupNavigationBar()
        setupButton()
        onChangeTextField()
    }
    
    private func onChangeTextField() {
        tfAmount.onValueChange = { [weak self] newValue in
            guard let self = self else { return }
            guard let valueWithoutGroupingSeparator = newValue.replacingOccurrences(of: ".", with: "") as String? else { return }
            var monthlyInterest = 0.0
            
            self.amount = newValue
            
            if let doubleValue = Double(valueWithoutGroupingSeparator) {
                let interestRate = 7.5 / 100
                monthlyInterest = (doubleValue * interestRate) / 12
            }
            
            if let formattedInterest = self.numberFormatter.string(from: NSNumber(value: monthlyInterest)) {
                self.lblInterestValue.text = "Rp \(formattedInterest)"
            }
        }
    }
    
    private func setupButton() {
        btnBack.addTarget(self, action: #selector(onBackButtonPressed), for: .touchUpInside)
        btnRollover.addTarget(self, action: #selector(onPressRollover), for: .touchUpInside)
        btnOpenNow.addTarget(self, action: #selector(onNavigateToPayment), for: .touchUpInside)
        
        lblRolloverValue.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onPressRollover))
        lblRolloverValue.addGestureRecognizer(tapGesture)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.hidesBackButton = true
        
        if let navigationController = self.navigationController {
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
            navigationController.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    private func setupUI() {
        ///
        /// ======= REMARK TOP SECTION =======
        ///
        view.backgroundColor = .white
        view.addSubview(topView)
        view.addSubview(btnBack)
        topView.addSubview(lblTitle)
        topView.addSubview(lblInterest)
        topView.addSubview(lblTotalMonth)
        topView.addSubview(lblDescription)
        ///
        /// ======= REMARK BOTTOM SECTION =======
        ///
        view.addSubview(bottomView)
        bottomView.addSubview(lblTotalDeposit)
        bottomView.addSubview(tfAmount)
        bottomView.addSubview(dashedLineView)
        bottomView.addSubview(lblDueDate)
        bottomView.addSubview(lblDueDateValue)
        bottomView.addSubview(lblInterestEstimation)
        bottomView.addSubview(lblInterestValue)
        ///
        /// ======= REMARK ROLLOVER  SECTION =======
        ///
        view.addSubview(rolloverView)
        rolloverView.addSubview(lblRollover)
        rolloverView.addSubview(lblRolloverValue)
        rolloverView.addSubview(btnRollover)
        rolloverView.addSubview(btnOpenNow)
        rolloverView.addSubview(btnTnc)
        rolloverView.addSubview(btnTncImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Top container constraints
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            btnBack.widthAnchor.constraint(equalToConstant: 20),
            btnBack.heightAnchor.constraint(equalToConstant: 20),
            
            // Back button constraints
            btnBack.topAnchor.constraint(equalTo: topView.topAnchor, constant: 8),
            btnBack.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 8),
            
            // Page title constraints
            lblTitle.topAnchor.constraint(equalTo: btnBack.bottomAnchor, constant: 16),
            lblTitle.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            lblTitle.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            
            // Interest and interval constraints
            lblInterest.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 16),
            lblInterest.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            
            lblTotalMonth.bottomAnchor.constraint(equalTo: lblDescription.topAnchor, constant: -16),
            lblTotalMonth.leadingAnchor.constraint(equalTo: lblInterest.trailingAnchor, constant: 24),
            
            // Description constraints
            lblDescription.topAnchor.constraint(equalTo: lblInterest.bottomAnchor, constant: 16),
            lblDescription.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            lblDescription.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            
            // Bottom container constraints
            bottomView.topAnchor.constraint(equalTo: lblDescription.bottomAnchor, constant: 16),
            bottomView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            bottomView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            // Total deposit constraints
            lblTotalDeposit.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            lblTotalDeposit.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            lblTotalDeposit.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            
            // Tf input amount constraints
            tfAmount.topAnchor.constraint(equalTo: lblTotalDeposit.bottomAnchor, constant: 24),
            tfAmount.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            tfAmount.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            tfAmount.heightAnchor.constraint(equalToConstant: 180),
            
            // Due Date Label
            lblDueDate.topAnchor.constraint(equalTo: tfAmount.bottomAnchor, constant: 16),
            lblDueDate.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            lblDueDateValue.topAnchor.constraint(equalTo: tfAmount.bottomAnchor, constant: 16),
            lblDueDateValue.leadingAnchor.constraint(equalTo: lblDueDate.trailingAnchor, constant: 8),
            
            // Separator constraints
            dashedLineView.topAnchor.constraint(equalTo: lblDueDate.bottomAnchor, constant: 16),
            dashedLineView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            dashedLineView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            dashedLineView.heightAnchor.constraint(equalToConstant: 1),
            
            // Interest estimation constraits
            lblInterestEstimation.topAnchor.constraint(equalTo: dashedLineView.bottomAnchor, constant: 16),
            lblInterestEstimation.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            lblInterestEstimation.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -8),
            
            lblInterestValue.topAnchor.constraint(equalTo: dashedLineView.bottomAnchor, constant: 16),
            lblInterestValue.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            lblInterestValue.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -8),
            
            // Rollover container constraints
            rolloverView.topAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 16),
            rolloverView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            rolloverView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            rolloverView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            lblRollover.topAnchor.constraint(equalTo: rolloverView.topAnchor, constant: 16),
            lblRollover.leadingAnchor.constraint(equalTo: rolloverView.leadingAnchor, constant: 16),
            
            lblRolloverValue.topAnchor.constraint(equalTo: rolloverView.topAnchor, constant: 16),
            lblRolloverValue.trailingAnchor.constraint(equalTo: btnRollover.leadingAnchor, constant: -16),
            
            btnRollover.centerYAnchor.constraint(equalTo: lblRolloverValue.centerYAnchor),
            btnRollover.trailingAnchor.constraint(equalTo: rolloverView.trailingAnchor, constant: -16),
            
            btnRollover.widthAnchor.constraint(equalToConstant: 10),
            btnRollover.heightAnchor.constraint(equalToConstant: 10),
            
            btnOpenNow.topAnchor.constraint(equalTo: lblRollover.bottomAnchor, constant: 24),
            btnOpenNow.leadingAnchor.constraint(equalTo: rolloverView.leadingAnchor, constant: 16),
            btnOpenNow.trailingAnchor.constraint(equalTo: rolloverView.trailingAnchor, constant: -16),
            
            // btnTnc constraints
            btnTnc.topAnchor.constraint(equalTo: btnOpenNow.bottomAnchor, constant: 16),
            btnTnc.leadingAnchor.constraint(equalTo: rolloverView.leadingAnchor, constant: 16),
            btnTnc.trailingAnchor.constraint(equalTo: rolloverView.trailingAnchor, constant: -16),
            btnTnc.bottomAnchor.constraint(equalTo: rolloverView.bottomAnchor, constant: -16),
            
            // btnTncImage constraints
            btnTncImage.centerYAnchor.constraint(equalTo: btnTnc.centerYAnchor),
            btnTncImage.trailingAnchor.constraint(equalTo: btnTnc.leadingAnchor, constant: 8),
        ])
    }
    
    @objc private func onBackButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func onNavigateToWebview() {
        let nextVc = WebviewViewController()
        navigationController?.pushViewController(nextVc, animated: true)
    }
    
    @objc private func onNavigateToPayment() {
        let nextVc = WealthPaymentViewController()
        if amount != "" {
            nextVc.amount = "Rp\(self.amount)"
        }
        navigationController?.pushViewController(nextVc, animated: true)
    }
    
    @objc private func onPressRollover() {
        let bottomSheetVC = RolloverSheetViewController()
        bottomSheetVC.updateSelectedOption(selectedIndex: selectedRollover)
        bottomSheetVC.delegate = self
        bottomSheetVC.modalPresentationStyle = .pageSheet
        
        if let sheet = bottomSheetVC.sheetPresentationController {
            sheet.detents = [.medium()] // half page
            sheet.preferredCornerRadius = 16
        }
        present(bottomSheetVC, animated: true, completion: nil)
    }
    
}

extension WealthDetailViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // Dismisses when tap outside keyboard
    }
}

extension WealthDetailViewController: BottomSheetDelegate {
    func didSelectOption(selectedIndex: Int) {
        self.selectedRollover = selectedIndex
        self.lblRolloverValue.text = RolloverOptions[selectedIndex].title
    }
}
