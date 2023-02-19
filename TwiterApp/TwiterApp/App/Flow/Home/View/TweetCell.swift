//
//  TweetCell.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/19.
//

import UIKit
import Kingfisher

class TweetCell: UITableViewCell {
    static let identifier = "TweetCell"
    
    private var photoWidthConstraint: NSLayoutConstraint?
    private var photoHeightConstraint: NSLayoutConstraint?
    
    private lazy var accountLogo = CustomImageView.accountIcon

    private lazy var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.inputText()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var time: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.secondaryInputText()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var content: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.inputText()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = R.color.photo_placeholder()
        imageView.kf.indicatorType = .activity
        imageView.layer.cornerRadius = 15
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var contentContainerView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [content, photoImageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 20
        return stackView
    }()
 
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(accountLogo)
        NSLayoutConstraint.activate([
            accountLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            accountLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        contentView.addSubview(userName)
        NSLayoutConstraint.activate([
            userName.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            userName.centerYAnchor.constraint(equalTo: accountLogo.centerYAnchor),
            userName.leadingAnchor.constraint(equalTo: accountLogo.trailingAnchor, constant: 10)
        ])
        
        contentView.addSubview(time)
        NSLayoutConstraint.activate([
            time.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            time.centerYAnchor.constraint(equalTo: userName.centerYAnchor),
            time.leadingAnchor.constraint(equalTo: userName.trailingAnchor)
        ])
        
        contentView.addSubview(contentContainerView)
        NSLayoutConstraint.activate([
            contentContainerView.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 15),
            contentContainerView.leadingAnchor.constraint(equalTo: accountLogo.trailingAnchor, constant: 10),
            contentContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            contentContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            content.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 10)
        ])
    }
    
    func setData(tweet: Tweet) {
        userName.text = tweet.userName
        time.text = "・" + Date(timeIntervalSince1970: Double(tweet.timestamp)).timeAgoDisplay()
        content.isHidden = tweet.content.isEmpty
        content.text = tweet.content
        content.sizeToFit()
        setupPhotoHeightConstraints(width: tweet.imageWidth, height: tweet.imageHeight)
        guard !tweet.imageURL.isEmpty else {
            photoImageView.isHidden = true
            photoImageView.image = nil
            return
        }
        photoImageView.isHidden = false
        photoImageView.kf.setImage(with: URL(string: tweet.imageURL))
    }
    
    private func setupPhotoHeightConstraints(width: Double, height: Double) {
        photoWidthConstraint?.isActive = false
        photoWidthConstraint = photoImageView.widthAnchor.constraint(equalToConstant: width)
        photoWidthConstraint?.isActive = true
        photoHeightConstraint?.isActive = false
        photoHeightConstraint = photoImageView.heightAnchor.constraint(equalToConstant: height)
        photoHeightConstraint?.isActive = true
    }
}
