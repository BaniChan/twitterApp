//
//  Date+Extension.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/19.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
