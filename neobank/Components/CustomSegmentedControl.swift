//
//  CustomSegmentedControl.swift
//  neobank
//
//  Created by Leon Natanto on 17/07/24.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl {
    private var underlineLayer = CALayer()
    private let underlineHeight: CGFloat = 2.0
    private let underlineColor = UIColor.TintColor.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSegmentedControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSegmentedControl()
    }
    
    init(items: [String]) {
        super.init(items: items)
        setupSegmentedControl()
        setSegmentItems(items)
    }
    
    
    private func setupSegmentedControl() {
        setTitleTextAttributes([.foregroundColor: UIColor.SubtitleColor], for: .normal)
        setTitleTextAttributes([.foregroundColor: UIColor.TitleColor], for: .selected)
        
        setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        layer.addSublayer(underlineLayer)
        
        setContentPositionAdjustment(UIOffset(horizontal: 0, vertical: -10), forSegmentType: .any, barMetrics: .default)
        
        updateUnderlineFrame()
        
        addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    private func setSegmentItems(_ items: [String]) {
        selectedSegmentIndex = 0
        updateUnderlineFrame()
    }
    
    private func updateUnderlineFrame() {
        guard numberOfSegments > 0 else { return }
        
        let segmentWidth = bounds.width / CGFloat(numberOfSegments)
        let underlineWidth: CGFloat = 50.0
        let selectedSegmentWidth = CGFloat(selectedSegmentIndex) * segmentWidth
        let underlineX = selectedSegmentWidth + (segmentWidth - underlineWidth) / 2.0
        
        underlineLayer.frame = CGRect(x: underlineX, y: bounds.height - underlineHeight, width: underlineWidth, height: underlineHeight)
        underlineLayer.backgroundColor = underlineColor
    }
    
    @objc private func segmentedValueChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.updateUnderlineFrame()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUnderlineFrame()
    }
}
