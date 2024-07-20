//
//  WealthListViewController.swift
//  neobank
//
//  Created by Leon Natanto on 16/07/24.
//

import UIKit
class WealthListViewController: UIViewController {
    
    private let lblTitle: UILabel = {
        let label = UILabel()
        label.text = "Wealth"
        label.textAlignment = .left
        label.textColor = UIColor.TitleColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let segmentedControl: CustomSegmentedControl = {
        let items = ["Fleksibel", "Bunga Tetap"]
        let segmentedControl = CustomSegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private let tvWealthList: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var viewModel: WealthListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = WealthListViewModel()
        setupUI()
        setupTv()
        setupConstraints()
        setupSegmentedControl()
        fetchData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(lblTitle)
        view.addSubview(segmentedControl)
        view.addSubview(tvWealthList)
    }
    
    private func setupTv() {
        tvWealthList.delegate = self
        tvWealthList.dataSource = self
        tvWealthList.register(WealthTableViewCell.self, forCellReuseIdentifier: WealthTableViewCell.identifier)
    }
    
    private func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // changing data base on index segmented
        viewModel.filterData(for: sender.selectedSegmentIndex)
        tvWealthList.reloadData()
    }
    
    private func fetchData() {
        viewModel.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.segmentedControl.removeAllSegments()
                    // set how many showed segmented from response API & set title
                    for (index, productGroup) in self.viewModel.wealthData?.data.enumerated() ?? [].enumerated() {
                        self.segmentedControl.insertSegment(withTitle: self.viewModel.getProductName(productGroup.productGroupName), at: index, animated: false)
                    }
                    self.segmentedControl.selectedSegmentIndex = 0
                    self.segmentedControl.sendActions(for: .valueChanged)
                }
            case .failure(let error):
                print("Error: ", error)
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Main title constraints
            lblTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            lblTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            lblTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            // Segmented control constraints
            segmentedControl.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),
            
            // Tv list constraints
            tvWealthList.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 0),
            tvWealthList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tvWealthList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tvWealthList.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension WealthListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredData[section].productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WealthTableViewCell.identifier, for: indexPath) as! WealthTableViewCell
        
        let product = viewModel.filteredData[indexPath.section].productList[indexPath.row]
        let concatenatedString = product.marketingPoints.joined(separator: ", ")
        let convertedAmount = StringFormatter.formatNumber(product.startingAmount)
        cell.configure(with: product.productName, description: concatenatedString, isPopular: product.isPopular, startingAmount: convertedAmount, rate: product.rate)
        
        // delegate & set selected index
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = UIColor.TitleColor
        titleLabel.text = viewModel.getProductName(viewModel.filteredData[section].productGroupName)
        
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension WealthListViewController: WealthTableViewCellDelegate {
    func onPressOpen(at indexPath: IndexPath) {
        let detailVC = WealthDetailViewController()
        let product = viewModel.filteredData[indexPath.section].productList[indexPath.row]
        
        detailVC.interest = Double(product.rate)
        detailVC.detailTitle = product.productName
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
