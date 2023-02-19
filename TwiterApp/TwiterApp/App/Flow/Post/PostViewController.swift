//
//  PostViewController.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import UIKit

class PostViewController: UIViewController {
    typealias ViewModel = PostViewModel
    private lazy var cancelButton = CustomButton.cancelButton
    private lazy var postButton = CustomButton.postButton
    private lazy var accountIcon = CustomImageView.accountIcon
    private lazy var addImageButton = CustomButton.addImageButton
    private lazy var deleteImageButton = CustomButton.deleteButton
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.isHidden = true
        return imageView
    }()
    private lazy var postContent = CustomTextView.postContent
    private lazy var placeholder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.secondaryInputText()
        label.text = R.string.localizable.whatSHappening()
        label.font = UIFont.systemFont(ofSize: 18)
        label.heightAnchor.constraint(equalToConstant: 18).isActive = true
        return label
    }()
    private lazy var displayName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.inputText()
        label.font = UIFont.systemFont(ofSize: 18)
        label.heightAnchor.constraint(equalToConstant: 18).isActive = true
        return label
    }()
    private lazy var loadingIndicator = CustomIndicatorView.loadingIndicator
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewController = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        postContent.becomeFirstResponder()
    }
    
    func setupUI() {
        view.backgroundColor = R.color.background()
        
        view.addSubview(cancelButton)
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])
        cancelButton.addTarget(viewModel, action: #selector(viewModel.clickCancelButton), for: .touchUpInside)
        
        view.addSubview(postButton)
        NSLayoutConstraint.activate([
            postButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
            postButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        postButton.addTarget(viewModel, action: #selector(viewModel.clickPostButton), for: .touchUpInside)
        
        view.addSubview(accountIcon)
        NSLayoutConstraint.activate([
            accountIcon.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 10),
            accountIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])
        
        view.addSubview(displayName)
        displayName.text = viewModel.userDisplayName
        NSLayoutConstraint.activate([
            displayName.centerYAnchor.constraint(equalTo: accountIcon.centerYAnchor),
            displayName.leadingAnchor.constraint(equalTo: accountIcon.trailingAnchor, constant: 10)
        ])
        
        view.addSubview(accountIcon)
        NSLayoutConstraint.activate([
            accountIcon.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 10),
            accountIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])
        
        view.addSubview(addImageButton)
        NSLayoutConstraint.activate([
            addImageButton.centerYAnchor.constraint(equalTo: accountIcon.centerYAnchor),
            addImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        addImageButton.addTarget(viewModel, action: #selector(viewModel.clickImageButton), for: .touchUpInside)
        
        view.addSubview(placeholder)
        NSLayoutConstraint.activate([
            placeholder.topAnchor.constraint(equalTo: accountIcon.bottomAnchor, constant: 15),
            placeholder.leadingAnchor.constraint(equalTo: accountIcon.trailingAnchor, constant: 15),
            placeholder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        view.addSubview(postContent)
        postContent.delegate = self
        NSLayoutConstraint.activate([
            postContent.topAnchor.constraint(equalTo: accountIcon.bottomAnchor, constant: 5),
            postContent.leadingAnchor.constraint(equalTo: accountIcon.trailingAnchor, constant: 10),
            postContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            postContent.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
        
        view.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(lessThanOrEqualToConstant: PhotoConstant.displayWidth),
            photoImageView.heightAnchor.constraint(lessThanOrEqualToConstant: PhotoConstant.displayHeight),
            photoImageView.topAnchor.constraint(equalTo: postContent.bottomAnchor, constant: 35),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -39)
        ])
        
        view.addSubview(deleteImageButton)
        deleteImageButton.isHidden = true
        NSLayoutConstraint.activate([
            deleteImageButton.topAnchor.constraint(equalTo: postContent.bottomAnchor, constant: 20),
            deleteImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        deleteImageButton.addTarget(viewModel, action: #selector(viewModel.clickDeleteImageButton), for: .touchUpInside)
        
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func updatePostButtonEnabled() {
        let isEnabled = viewModel.canEnablePostButton
        postButton.isEnabled = isEnabled
        postButton.backgroundColor = isEnabled ? CustomButton.enableBackgroundColor : CustomButton.disableBackgroundColor
    }
}

extension PostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholder.isHidden = !textView.text.isEmpty
        textView.sizeToFit()
        updatePostButtonEnabled()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text.rangeOfCharacter(from: CharacterSet.newlines) == nil else { return false }
        return textView.text.count + (text.count - range.length) <= 140
    }
}

extension PostViewController: PostViewModelOutput {
    var content: String {
        postContent.text
    }
    
    func showImageSourceSelection() {
        let alert = UIAlertController(title: R.string.localizable.choosePhotoSource(), message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: R.string.localizable.camera(), style: .default, handler: { [weak self] _ in
            self?.openCamera()
        }))
        alert.addAction(UIAlertAction(title: R.string.localizable.gallery(), style: .default, handler: { [weak self] _ in
            self?.openGallery()
        }))
        alert.addAction(UIAlertAction.init(title: R.string.localizable.cancel(), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showImage(_ show: Bool) {
        let scaledImage = viewModel.selectedImage?.resize(withSize: CGSize(width: PhotoConstant.displayWidth, height: PhotoConstant.displayHeight), contentMode: .contentAspectFit)
        viewModel.scaledImage = scaledImage
        photoImageView.image = scaledImage
        photoImageView.sizeToFit()
        addImageButton.isHidden = show
        deleteImageButton.isHidden = !show
        photoImageView.isHidden = !show
        updatePostButtonEnabled()
    }
    
    func dismiss() {
         dismiss(animated: true)
    }
    
    func showLoading(_ show: Bool) {
        if show {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
    
    func showError(_ error: String?) {
        guard let error = error else { return }
        let alert = UIAlertController(
            title: R.string.localizable.somethingWrong(),
            message: error.description,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.tryAgain(), style: UIAlertAction.Style.default) { [weak self] action in
            self?.viewModel.clickPostButton()
        })
        alert.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        viewModel.selectedImage = image
        showImage(true)
        dismiss(animated: true, completion: nil)
    }
}
