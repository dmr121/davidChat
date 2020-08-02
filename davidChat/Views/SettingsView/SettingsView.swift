//
//  SettingsView.swift
//  davidChat
//
//  Created by David Rozmajzl on 8/1/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    
    @EnvironmentObject var loginManager: LoginManager
    //@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    @State var isActive = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.logOut()
            }) {
                HStack {
                    Spacer()
                    Text("Log Out")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                    Spacer()
                }
                .padding()
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(.horizontal)
            }
            .padding(.vertical)
            
            if !loginManager.isLoggedIn {
                Text("Close this app in your app manager to complete logout.")
                .fontWeight(.semibold)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
    .navigationBarTitle("Settings")
    }
}

extension SettingsView {
    func logOut() {
        do {
            try Auth.auth().signOut()
            self.loginManager.unsaveLogin()
        } catch {
            print("Error Signing Out: \(error)")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
