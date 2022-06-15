//
//  AccountView.swift
//  swiftapp
//
//  Created by Josef Malý on 14.06.2022.
//

import SwiftUI

struct AccountView: View {

	@EnvironmentObject var session: SessionManager

	var body: some View {
		let email: String = session.loggedUser?.email ?? "preview"
		VStack {
			Text("Hello, \(email)")
			Button {
				session.logout()
			} label: {
				Image(systemName: "chevron.left.circle.fill")
					.frame(width: 100, height: 100)
					.font(.system(size: 80))
			}
		}
	}
}

struct AccountView_Previews: PreviewProvider {
	static var previews: some View {
		AccountView()
	}
}
