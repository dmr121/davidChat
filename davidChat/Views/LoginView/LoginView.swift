//
//  LoginView.swift
//  davidChat
//
//  Created by David Rozmajzl on 7/31/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    // MARK: State Vars
    @State var email = ""
    @State var password = ""
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
                    .padding(.bottom)
                
                NavigationLink(destination: MessagesView().environmentObject(loginManager), isActive: $isActive) {
                    Button(action: {
                        self.signIn()
                    }) {
                        HStack {
                            Spacer()
                            
                            Text("Login")
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
                .padding(.bottom)
                .offset(x: password.count > 0 ? 0 : 600, y: 0)
                .animation(.spring())
                .disabled(attemptingLogin)
                
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
        .navigationBarTitle("Login")
    }
}

extension LoginView {
    private func signIn() {
        attemptingLogin = true
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else { // Firebase error
                self.jiggleBox()
                self.errorMessage = error?.localizedDescription
                self.attemptingLogin = false
                return
            }
            
            print("User Email: \(user.email!)")
            self.loginManager.saveLogin(name: user.email!)
            self.isActive = true
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
