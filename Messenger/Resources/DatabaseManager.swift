//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Kaori Persson on 2022-06-04.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    // Make the class singleton
    static let shared = DatabaseManager()
    
    private let database = Database.database(url: "https://messenger-dac3c-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
}

// MARK: - Account management
extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        // To avoid the error with Firebase 'InvalidPathValidation', reason: '(child:) Must be a non-empty string and not contain '.' '#' '$' '[' or ']''
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                // email does not exist
                completion(false)
                return
            }
            
            // if email exist
            completion(true)
            
        })
    }
    
    /// Inserts new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}