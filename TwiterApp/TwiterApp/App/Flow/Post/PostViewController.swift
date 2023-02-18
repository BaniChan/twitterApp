//
//  PostViewController.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import UIKit

class PostViewController: UIViewController {
    typealias ViewModel = PostViewModel
    private let cancelButton = CustomButton.cancelButton
    private let postButton = CustomButton.postButton
    private let accountIcon = CustomImageView.accountIcon
    private let addPhotoButton = CustomButton.addPhotoButton
    private let deletePhotoButton = CustomButton.deleteButton
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.isHidden = true
        return imageView
    }()
    private let postContent = CustomTextView.postContent
    private let placeholder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.secondaryInputText()
        label.text = R.string.localizable.whatSHappening()
        label.font = UIFont.systemFont(ofSize: 18)
        label.heightAnchor.constraint(equalToConstant: 18).isActive = true
        return label
    }()
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
        
        view.addSubview(accountIcon)
        NSLayoutConstraint.activate([
            accountIcon.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 10),
            accountIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])
        
        view.addSubview(addPhotoButton)
        NSLayoutConstraint.activate([
            addPhotoButton.centerYAnchor.constraint(equalTo: accountIcon.centerYAnchor),
            addPhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        addPhotoButton.addTarget(viewModel, action: #selector(viewModel.clickPhotoButton), for: .touchUpInside)
        
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
            photoImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            photoImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 400),
            photoImageView.topAnchor.constraint(equalTo: postContent.bottomAnchor, constant: 35),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -39)
        ])
        
        view.addSubview(deletePhotoButton)
        deletePhotoButton.isHidden = true
        NSLayoutConstraint.activate([
            deletePhotoButton.topAnchor.constraint(equalTo: postContent.bottomAnchor, constant: 20),
            deletePhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        deletePhotoButton.addTarget(viewModel, action: #selector(viewModel.clickDeletePhotoButton), for: .touchUpInside)
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
}

extension PostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholder.isHidden = !textView.text.isEmpty
        textView.sizeToFit()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text.rangeOfCharacter(from: CharacterSet.newlines) == nil else { return false }
        return textView.text.count + (text.count - range.length) <= 140
    }
}

extension PostViewController: PostViewModelOutput {
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
    
    func showPhoto(_ show: Bool) {
        let scaledImage = viewModel.selectedImage?.resize(withSize: CGSize(width: 250, height: 400), contentMode: .contentAspectFit)
        photoImageView.image = scaledImage
        photoImageView.sizeToFit()
        addPhotoButton.isHidden = show
        deletePhotoButton.isHidden = !show
        photoImageView.isHidden = !show
    }
    
    func dismiss() {
         dismiss(animated: true)
    }
}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        viewModel.selectedImage = image
        showPhoto(true)
        dismiss(animated: true, completion: nil)
    }
}
