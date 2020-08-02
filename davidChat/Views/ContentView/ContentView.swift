//
//  ContentView.swift
//  davidChat
//
//  Created by David Rozmajzl on 7/31/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var loginManager: LoginManager
    
    var body: some View {
        NavigationView {
            
            if loginManager.isLoggedIn {
                MessagesView().environmentObject(loginManager)
            } else {
                
                ZStack {
                    
                    VStack {
                        Image(systemName: "ellipses.bubble.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.blue)
                        
                        Text("David Chat")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)
                            .padding(.top, 10)
                    }
                    
                    VStack {
                        Spacer()
                        
                        NavigationLink(destination: LoginView().environmentObject(loginManager)) {
                            HStack {
                                Spacer()
                                
                                Text("Log in")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Spacer()
                            }
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .padding()
                        }
                        .isDetailLink(false)
                        
                        NavigationLink(destination: SignUpView().environmentObject(loginManager)) {
                            Text("Sign up")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .padding(.bottom)
                        }
                        .isDetailLink(false)
                    }
                }
            }
        }
    }
}
