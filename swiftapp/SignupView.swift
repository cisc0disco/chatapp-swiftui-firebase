//
//  SignupView.swift
//  swiftapp
//
//  Created by Josef Malý on 14.06.2022.
//

import SwiftUI
import AlertToast

struct SignupButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20))
            .padding(4)
            .padding(.horizontal, 60)
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(17)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
            .shadow(radius: 5, y: 2)
            .offset(y: 20)
    }
}

struct SignupView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State private var showToast = false

    @Binding var showSignup: Bool
    
    @EnvironmentObject var session: SessionManager
    
    @State var errorName: String = ""
    
    var body: some View {
        ZStack {
            Color.white
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
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                /*
                Button(action: {
                    if (password == confirmPassword)
                    {
                        session.signup(email: email, password: password)
                        
                        
                        if (session.errorType != nil)
                        {
                            switch session.errorType
                            {
                            case .emailAlreadyInUse:
                                errorName = "Email is already in use"
                            case .invalidEmail:
                                errorName = "Email is badly formatted"
                            case .weakPassword:
                                errorName = "Password is too weak"
                            default:
                                print("Error!!!")
                            }
                            session.errorType = nil
                            
                            showToast.toggle()
                        }
                    } else
                    {
                        errorName = "Passwords do not match"
                        showToast.toggle()
                    }
                }) {
                    Text("Create account")
                }.buttonStyle(SignupButton())
                 */
                    
                    
            }.padding(.horizontal, 50)
        }.toast(isPresenting: $showToast){
            
            AlertToast(type: .error(.red), title: errorName)

        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static let sessionObj = SessionManager()
    @State static var showSignup: Bool = true
    static var previews: some View {
        SignupView(showSignup: $showSignup).environmentObject(sessionObj)
    }
}
