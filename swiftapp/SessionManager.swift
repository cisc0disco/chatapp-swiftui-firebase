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

	func login(email: String, password: String, completion: @escaping (AuthErrorCode.Code?, Bool?) -> Void)
	{
		Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in

			guard error == nil else {
				let error = error as? NSError

				completion(AuthErrorCode(_nsError: error!).code, false)
				return
			}

			self.loggedUser = Auth.auth().currentUser

			completion(nil, true)
		}
	}

	func login(email: String, password: String) async -> String
	{
		await withCheckedContinuation { continuation in
			login(email: email, password: password) { errorType, success in
				if (!success!)
				{
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
				} else if (success!)
				{
					continuation.resume(returning: "ok")
				}
			}
		}
	}

	func signup(email: String, password: String, completion: @escaping (AuthErrorCode.Code?, Bool?) -> Void)
	{
		Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in

			guard error == nil else {
				let error = error as? NSError
				completion(AuthErrorCode(_nsError: error!).code, false)
				return
			}

			self.db.addData(uid: authResult!.user.uid)
			print(authResult!)
			completion(nil, true)
		}
	}

	func signup(email: String, password: String) async -> String
	{
		await withCheckedContinuation { continuation in
			signup(email: email, password: password) { errorType, success in
				if (!success!)
				{
					var errorString: String = ""

					switch errorType
					{
					case .weakPassword:
						errorString = "Wrong password"
					case .emailAlreadyInUse:
						errorString = """
                        Email aready
                        in use
                        """
					case .invalidEmail:
						errorString = "Invalid email"
					case .missingEmail:
						errorString = "Missing email"
					default:
						errorString = ""
					}

					continuation.resume(returning: errorString)
				} else if (success!)
				{
					continuation.resume(returning: "ok")
				}
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
