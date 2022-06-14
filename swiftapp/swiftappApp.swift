//
//  swiftappApp.swift
//  swiftapp
//
//  Created by Josef Malý on 13.06.2022.
//

import SwiftUI
import FirebaseCore
import Firebase
import Foundation
import FirebaseFirestore

@main
struct swiftappApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	@StateObject var session = SessionManager()

	var body: some Scene {
		WindowGroup {
			ContentView().environmentObject(session)
		}
	}

	//Firebase init
	class AppDelegate: NSObject, UIApplicationDelegate {
		func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
			FirebaseApp.configure()

			return true
		}
	}
}
