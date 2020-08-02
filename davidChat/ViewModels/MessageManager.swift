//
//  ChatsManager.swift
//  davidChat
//
//  Created by David Rozmajzl on 8/1/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import Foundation
import SwiftUI

class MessageManager: ObservableObject {
    @Published var messages = [Message]()
    let firestoreManager = FirestoreManager()
    
    func sendMessage(sender: String, body: String, completion: @escaping () -> ()) {
        let message = Message(id: "", sender: sender, body: body, dateTime: Date())
        firestoreManager.sendMessage(message: message, completion: completion)
    }
    
    init() {
        firestoreManager.getMessages { messages in
            self.messages = messages
        }
    }
}
