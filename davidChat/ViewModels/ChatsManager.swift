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
    @Published var chats = [Chat]()
    let firestoreManager = FirestoreManager()
    
    init() {
        firestoreManager.getChats { chat in
            self.chats.append(chat)
        }
    }
}
