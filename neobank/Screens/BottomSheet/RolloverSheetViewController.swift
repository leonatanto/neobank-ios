//
//  RolloverSheetViewController.swift
//  neobank
//
//  Created by Leon Natanto on 18/07/24.
//

import UIKit

protocol BottomSheetDelegate: AnyObject {
    func didSelectOption(selectedIndex: Int)
}

class RolloverSheetViewController: UIViewController {
    weak var delegate: BottomSheetDelegate?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(OptionRolloverTableViewCell.self, forCellReuseIdentifier: "OptionRolloverTableViewCell")
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let lblTitleSheet: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.TitleColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "Opsi Rollover"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.addSubview(lblTitleSheet)
        
        NSLayoutConstraint.activate([
            lblTitleSheet.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            lblTitleSheet.centerXAnchor.constraint(equalTo: view.centerXAnchor) ,
            tableView.topAnchor.constraint(equalTo: lblTitleSheet.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
        
        // handle detent = medium for height sheet
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 16
        }
    }
    
    func updateSelectedOption(selectedIndex: Int) {
        for i in 0..<RolloverOptions.count {
            RolloverOptions[i].isSelected = (i == selectedIndex)
        }
        tableView.reloadData()
    }
}

extension RolloverSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RolloverOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionRolloverTableViewCell", for: indexPath) as! OptionRolloverTableViewCell
        let option = RolloverOptions[indexPath.row]
        cell.configure(option: option)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        updateSelectedOption(selectedIndex: selectedIndex)
        
        delegate?.didSelectOption(selectedIndex: selectedIndex)
        dismiss(animated: true, completion: nil)
    }
}
