//
//  LoginView.swift
//  swiftapp
//
//  Created by Josef Malý on 13.06.2022.
//

import SwiftUI
import Firebase
import AlertToast

struct SignInButton: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.font(.system(size: 20))
			.padding(8)
			.padding(.horizontal, 115)
			.background(.blue)
			.foregroundColor(.white)
			.cornerRadius(17)
			.scaleEffect(configuration.isPressed ? 1.2 : 1)
			.animation(.easeOut(duration: 0.1), value: configuration.isPressed)
			.shadow(radius: 5, y: 2)
	}
}

struct SignUpButton: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.font(.system(size: 20))
			.padding(8)
			.foregroundColor(.blue)
			.cornerRadius(17)
			.shadow(radius: 5, y: 2)
	}
}

struct LoginView: View {
	@State var email: String = ""
	@State var password = ""
	@State private var showError = false
	@State var showSignup = false
	@State var errorName: String = ""
	@State private var showToast = false
	@State private var loggedIn = false

	@EnvironmentObject var session: SessionManager

	var body: some View {
		NavigationView {
			ZStack {
				Color.white

				VStack() {
					Image(systemName: "lock.circle").resizable().frame(width: 150, height: 150, alignment: .center).offset(y: -100).offset(y: -30).shadow(radius: 20).foregroundColor(.blue)
					VStack(spacing: 20) {

						VStack(spacing: 10) {
							TextField("Email", text: $email)
								.padding(10)
								.autocapitalization(.none)
								.background(.white)
								.cornerRadius(20)
								.disableAutocorrection(true)
								.shadow(radius: 5)
							SecureField("Password", text: $password)
								.padding(10)
								.background(.white)
								.cornerRadius(20)
								.shadow(radius: 5)


						}.padding(.horizontal, 50)
						Button(action: {
							Task {
								errorName = await session.login(email: email, password: password)

								if (errorName == "ok")
								{
									loggedIn = true
								} else
								{
									loggedIn = false
								}

								showToast.toggle()
							}

						}) {
							Text("Login")
						}.buttonStyle(SignInButton())

						Button("Don't have an account? Sign up") {
							showSignup = true
						}.buttonStyle(SignUpButton())
							.padding(10)
							.popover(isPresented: $showSignup, arrowEdge: .top) {
							SignupView(showSignup: $showSignup).environmentObject(session)
								.interactiveDismissDisabled()
						}.toast(isPresenting: $showToast, duration: 1, tapToDismiss: false, alert: {
							if (loggedIn)
							{
								return AlertToast(type: .complete(.green), title: "Logged in")
							} else
							{
								return AlertToast(type: .error(.red), title: errorName)
							}
						}, completion: {
								if (loggedIn)
								{
									session.loggedIn = true
								}
							})


					}.offset(y: -50)
					//session.signup(email: email, password: password)
				}
			}
		}
	}
}



struct LoginView_Previews: PreviewProvider {
	static let sessionObj = SessionManager()
	static var previews: some View {
		Group {
			LoginView().environmentObject(sessionObj).previewInterfaceOrientation(.portrait)
		}
	}
}

