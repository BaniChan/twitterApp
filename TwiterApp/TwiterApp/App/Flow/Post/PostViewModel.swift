//
//  PostViewModel.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import UIKit
import Foundation
import Resolver

protocol PostViewModelOutput {
    func dismiss()
    func showImageSourceSelection()
    func showPhoto(_ show: Bool)
}

class PostViewModel {
    typealias ViewController = PostViewModelOutput
    
    @Injected private var dbRepository: DBRepositoryProtocol
    
    var viewController: ViewController?
    var selectedImage: UIImage?
    
    @objc func clickCancelButton() {
        viewController?.dismiss()
    }
    
    @objc func clickPostButton() {

    }
    
    @objc func clickPhotoButton() {
        viewController?.showImageSourceSelection()
    }
    
    @objc func clickDeletePhotoButton() {
        viewController?.showPhoto(false)
    }
}
