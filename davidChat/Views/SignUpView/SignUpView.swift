//
//  SignUpView.swift
//  davidChat
//
//  Created by David Rozmajzl on 7/31/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    // MARK: State Vars
    @State var email = ""
    @State var password = ""
    @State var passwordVerify = ""
    @State var isActive = false
    @State var jiggle = 0
    @State var errorMessage: String? = nil
    @State var attemptingLogin = false
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var loginManager: LoginManager
    
    var body: some View {
        ZStack {
            
            VStack {
                EmailTextField(input: $email)
                
                PasswordTextField(input: $password, placeholder: "Password")
                
                VStack {
                    HStack {
                        PasswordTextField(input: $passwordVerify, placeholder: "Verify password")
                        
                        Circle().frame(width: 14, height: 14)
                            .foregroundColor((password == passwordVerify && password.count >= 6) ? .green : .red)
                    }
                    .padding(.bottom)
                    
                    NavigationLink(destination: MessagesView().environmentObject(loginManager), isActive: $isActive) {
                        Button(action: {
                            self.createNewUser()
                        }) {
                            HStack {
                                Spacer()
                                
                                Text("Sign up")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(colorScheme == .dark ? .black : .white)
                                
                                Spacer()
                            }
                            .padding()
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .animation(.none)
                            .offset(x: CGFloat(jiggle), y: 0)
                        }
                    }
                .isDetailLink(false)
                .disabled(attemptingLogin)
                }
                .offset(x: password.count > 0 ? 0 : 600, y: 0)
                .animation(.spring())
                .padding(.bottom)
                
                if errorMessage != nil {
                    Text(errorMessage!)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
            }
            .padding([.horizontal, .top])
        }
        .navigationBarTitle("New User")
    }
}

extension SignUpView {
    private func createNewUser() {
        attemptingLogin = true
        if password == passwordVerify { // Passwords match
            if password.count >= 6 { // Must be a minimum of 6 characters as per Firebase rules
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    guard let user = authResult?.user, error == nil else { // Firebase error
                        self.jiggleBox()
                        self.errorMessage = error?.localizedDescription
                        self.attemptingLogin = false
                        return
                    }
                    
                    print("User Email, \(user.email!), created!")
                    self.loginManager.saveLogin(name: user.email!)
                    self.isActive = true // Activates the transition to the main content screen
                    self.attemptingLogin = false
                }
            } else { // Passwords is less than 6 characters
                jiggleBox()
                errorMessage = "Passwords must be at least 6 characters."
                self.attemptingLogin = false
            }
        } else { // Passwords don't match
            jiggleBox()
            errorMessage = "Your password doesn't match."
            self.attemptingLogin = false
        }
    }
    
    private func jiggleBox() {
        jiggle = 6
        var positiveJiggle: Float = 6
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            positiveJiggle -= 1
            self.jiggle = Int(positiveJiggle) * Int(pow(-1.0, positiveJiggle))
            
            if positiveJiggle == 0 {
                timer.invalidate()
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
