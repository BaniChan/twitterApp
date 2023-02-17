//
//  CustomTextView.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import UIKit
import Foundation

struct CustomTextView {
    static var postContent: UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = R.color.inputText()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        return textView
    }
}
