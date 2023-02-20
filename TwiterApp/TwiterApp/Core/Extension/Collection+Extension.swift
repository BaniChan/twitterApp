//
//  Collection+Extension.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
