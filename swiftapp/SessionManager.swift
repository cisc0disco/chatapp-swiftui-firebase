//
//  SessionManager.swift
//  swiftapp
//
//  Created by Josef Malý on 13.06.2022.
//

import Foundation
import Firebase
import SwiftUI
import FirebaseAuth
import AlertToast

class SessionManager: ObservableObject {
    
    var db = DatabaseManager()
    
    @Published var loggedUser: User?
    @Published var loggedIn: Bool = false
    @Published var canShowToast: Bool?
    
    func login(email: String, password: String, completion: @escaping (AuthErrorCode.Code) -> Void)
    {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            
            guard error == nil else {
                let error = error as? NSError
                
                completion(AuthErrorCode(_nsError: error!).code)
                return
            }
                
            self.loggedUser = Auth.auth().currentUser
            self.loggedIn = true
        }
    }
    
    func login(email: String, password: String) async -> String
    {
        await withCheckedContinuation { continuation in
            login(email: email, password: password) { errorType in
                var errorString: String = ""
                
                switch errorType
                {
                case .wrongPassword:
                    errorString = "Wrong password"
                case .userNotFound:
                    errorString = "User not found"
                case .invalidEmail:
                    errorString = "Invalid email"
                default:
                    errorString = ""
                }
                
                continuation.resume(returning: errorString)
            }
        }
    }
    
    func signup(email: String, password: String)
    {
        Auth.auth().createUser(withEmail: email, password: password) {authResult, error in
            if let error = error as? NSError
            {
                //self.errorType = AuthErrorCode.Code(rawValue: error.code)
            }
            else {

                self.db.addData(uid: authResult!.user.uid)
                print(authResult!)
            }
        }

    }
    
    func logout() {
        self.loggedIn = false
        self.loggedUser = nil
        do {
            try Auth.auth().signOut()
        } catch(let error) {
            debugPrint(error.localizedDescription)
        }
    }
}
