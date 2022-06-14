//
//  ContentView.swift
//  swiftapp
//
//  Created by Josef Malý on 13.06.2022.
//

import SwiftUI
import Firebase

struct ContentView: View {

	@EnvironmentObject var session: SessionManager

	var body: some View {
		if (session.loggedIn == false) {
			LoginView().environmentObject(session).preferredColorScheme(.light)
		} else {
			HomepageView().environmentObject(session)
		}

	}
}

struct ContentView_Previews: PreviewProvider {
	static let sessionObj = SessionManager()
	static var previews: some View {
		Group {
			ContentView().environmentObject(sessionObj)
		}
	}
}
