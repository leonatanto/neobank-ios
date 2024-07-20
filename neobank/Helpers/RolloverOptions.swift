//
//  RolloverOptions.swift
//  neobank
//
//  Created by Leon Natanto on 18/07/24.
//

import Foundation

public struct Options {
    let title: String
    var isSelected: Bool
    let description: String
    let secondDescription: String
    
    public init(title: String, isSelected: Bool, description: String, secondDescription: String) {
        self.title = title
        self.isSelected = isSelected
        self.description = description
        self.secondDescription = secondDescription
    }
}

public var RolloverOptions: [Options] = [
    Options(title: "Pokok", isSelected: false, description: "Bunga dikirim ke saldo aktif setelah jatuh tempo. Nilai pokok otomatis diperpanjang dengan jangka waktu deposito yang sama", secondDescription: "Suku bunga saat ini aka dihitung berdasarkan `suku bunga dasar + suku bunga tambahan` dan suku bunga saat roll-over akan dihitung berdasarkan suku bunga yang berlaku di tanggal roll-over."),
    Options(title: "Pokok + Bunga", isSelected: false, description: "Nilai pokok + bunga otomatis diperpanjang dengan jangka waktu deposito yang sama.", secondDescription: "Suku bunga saat ini aka dihitung berdasarkan `suku bunga dasar + suku bunga tambahan` dan suku bunga saat roll-over akan dihitung berdasarkan suku bunga yang berlaku di tanggal roll-over."),
    Options(title: "Tidak diperpanjang", isSelected: false, description: "Nilai pokok & bunga otomatis masuk ke saldo aktif etelah lewat jatuh tempo.", secondDescription: "")
]
