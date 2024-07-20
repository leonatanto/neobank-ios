//
//  StringFormatter.swift
//  neobank
//
//  Created by Leon Natanto on 16/07/24.
//

import Foundation

class StringFormatter {
    
    static func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "id_ID")
        
        var formattedString = ""
        
        if number >= 1_000_000 {
            let million = number / 1_000_000
            formattedString = "\(million) jt"
        } else if number >= 1_000 {
            let thousand = number / 1_000
            formattedString = "\(thousand) rb"
        } else {
            formattedString = "\(number)"
        }
        
        return formattedString
    }
}
