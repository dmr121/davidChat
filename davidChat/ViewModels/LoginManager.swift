//
//  LoginManager.swift
//  davidChat
//
//  Created by David Rozmajzl on 8/1/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import Foundation
import SwiftUI

class LoginManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var username: String?
    let loggedIn = "isLoggedIn"
    let name = "name"
    
    init() {
        isLoggedIn = UserDefaults.standard.bool(forKey: loggedIn)
        username = UserDefaults.standard.string(forKey: name)
    }
    
    func saveLogin(name: String) {
        UserDefaults.standard.set(true, forKey: loggedIn)
        isLoggedIn = UserDefaults.standard.bool(forKey: loggedIn)
        UserDefaults.standard.set(name, forKey: self.name)
        username = name
    }
    
    func unsaveLogin() {
        UserDefaults.standard.set(false, forKey: loggedIn)
        isLoggedIn = UserDefaults.standard.bool(forKey: loggedIn)
        UserDefaults.standard.removeObject(forKey: name)
        username = nil
    }
}
