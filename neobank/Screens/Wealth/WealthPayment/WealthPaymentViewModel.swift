//
//  WealthPaymentViewModel.swift
//  neobank
//
//  Created by Leon Natanto on 20/07/24.
//

import Foundation

class WealthPaymentViewModel {
    let sections: [(title: String, image: String, description: String)] = [
        ("Virtual Account", "card" , "Kamu bisa bayar dengan kode virtual account dari salah satu bank dibawah. Jika nominal pembayaran lebih besar dari limit transfer satu kali bank yang dipilih, kamu dapat melakukan beberapa kali top uop ke rekening Tabungan Reguler atau rekenin Tabungan NOW kamu dan melanjutkan pembayaran menggunakan saldomu setelahnya."),
        ("BCA Virtual Account", "bca", "Description bca"),
        ("BRI Virtual Account","bri", "Description bri"),
        ("BNI Virtual Account","bni", "Description bni"),
        ("Danamon Virtual Account","danamon", "Description danamon"),
        ("Permata Virtual Account", "permata","Description permata"),
        ("CIMB Virtual Account", "cimb","Description cimb"),
    ]
}
