//
//  DatabaseManager.swift
//  swiftapp
//
//  Created by Josef Malý on 14.06.2022.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class DatabaseManager : ObservableObject
{
    @Published var db: Firestore?
    init()
    {
        self.db = Firestore.firestore()
    }
    
    func addData(uid: String)
    {
        var ref: DocumentReference? = nil
        
        ref = self.db!.collection("users").addDocument(data: [
            "uid": uid
        ]) { err in
            if let err = err {
                print(err)
            } else {
                print("Document add with id \(ref!.documentID)")
            }
            
        }
    }
}
