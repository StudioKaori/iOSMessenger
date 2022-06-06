//
//  StorageManager.swift
//  Messenger
//
//  Created by Kaori Persson on 2022-06-06.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    // the image url will be: /images/kaori-gmail-com_profile_picture.png
    // cache the profile image in the device to avoid reading it from Firestore everytime
    // uploads picture to firebase storage and returns  completion with url string to download
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    public func uploadProfilePicture(with data: Data,
                                     fileName: String,
                                     completion: @escaping(UploadPictureCompletion)) {
        storage.child("images/\(fileName)").putData(data,
                                                    metadata: nil,
                                                    completion: { metadata, error in
            guard error == nil else {
                // in case of error
                completion(.failure(Error))
                return
            }
        })
    }
}
