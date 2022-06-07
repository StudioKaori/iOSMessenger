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
                print("Failed to upload data to firebase for picture. Error: \(error)")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            // Get image url
            self.storage.child("images/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else {
                    print("Failed to get download url.")
                    if let error = error {
                        print("Download Error: \(error)")
                    }
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("Download url returned: \(urlString)")
                completion(.success(urlString))
                
            })
        })
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    }
    
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = storage.child(path)
        
        reference.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }
            
            completion(.success(url))
        })
    }
}
