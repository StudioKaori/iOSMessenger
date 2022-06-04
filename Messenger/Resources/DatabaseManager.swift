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
    
    public func test() {
        
        database.child("foo").setValue(["something": true])
    }
    
}
