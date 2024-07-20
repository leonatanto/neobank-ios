//
//  ColorExtension.swift
//  neobank
//
//  Created by Leon Natanto on 16/07/24.
//

import Foundation
import UIKit

extension UIColor {
    static let GrowthColor = UIColor(hex: "#0EBE5A")
    static let TintColor = UIColor(hex: "#FFD400")
    static let TitleColor = UIColor(hex: "#000000")
    static let SubtitleColor = UIColor(hex: "#515151")
    static let GrayColor = UIColor(hex: "c6c6c6")
    static let LightGrayColor = UIColor(hex: "#d3d3d3")
    static let BackgroundColor = UIColor(hex: "#F5F5F5")
    static let LinkColor = UIColor(hex: "#0085FF")
    
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
