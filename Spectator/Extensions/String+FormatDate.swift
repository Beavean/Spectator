//
//  String+FormatDate.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

extension String {
    func formatDate() -> String? {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatterInput.date(from: self) {
            let dateFormatterOutput = DateFormatter()
            dateFormatterOutput.dateFormat = "dd.MM.yyyy"
            return dateFormatterOutput.string(from: date)
        }
        return nil
    }
}
