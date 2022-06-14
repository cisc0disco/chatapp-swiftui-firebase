//
//  HomepageView.swift
//  swiftapp
//
//  Created by Josef Malý on 13.06.2022.
//

import SwiftUI

struct HomepageView: View {

	@EnvironmentObject var session: SessionManager

	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()
			TabView {
				ChatView()
					.tabItem {
					Label("Chat", systemImage: "message")
				}

				AccountView()
					.tabItem {
					Label("Account", systemImage: "person")
				}
			}
		}
	}
}

struct HomepageView_Previews: PreviewProvider {

	static let sessionObj = SessionManager()

	static var previews: some View {
		HomepageView().environmentObject(sessionObj)
	}
}
