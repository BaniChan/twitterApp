//
//  CustonImageView.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import UIKit

struct CustonImageView {
    static var smaillIcon: UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.image.icon_pine()
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return imageView
    }
}
