//
//  StorageService.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/18.
//

import FirebaseStorage
import Foundation
import UIKit

protocol StorageServiceProtocol {
    func uploadImage(image: UIImage, completion: @escaping (URL?, Error?) -> Void)
    func deleteImage(by imageUrl: String, completion: @escaping (Error?) -> Void)
}

class StorageService: StorageServiceProtocol {
    lazy var storage = Storage.storage().reference()
    
    func uploadImage(image: UIImage, completion: @escaping (URL?, Error?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let filename = NSUUID().uuidString
        let ref = storage.child(StorageConstant.PostImage).child(filename)
        
        ref.putData(imageData) { [weak self] (meta, error) in
            guard error == nil
            else {
                completion(nil, error)
                return
            }
            self?.downloadURL(ref, completion: completion)
        }
    }
    
    private func downloadURL(_ ref: StorageReference, completion: @escaping (URL?, Error?) -> Void) {
        ref.downloadURL { (url, error) in
            completion(url, error)
        }
    }
    
    func deleteImage(by url: String, completion: @escaping (Error?) -> Void) {
        let ref = Storage.storage().reference(forURL: url)
        ref.delete { error in
            completion(error)
        }
    }
}
