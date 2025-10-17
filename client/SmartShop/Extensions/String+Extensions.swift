//
//  String+Extensions.swift
//  SmartShop
//
//  Created by Luke on 10/16/25.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
