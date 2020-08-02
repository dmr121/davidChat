//
//  Chat.swift
//  davidChat
//
//  Created by David Rozmajzl on 8/1/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import Foundation

struct Chat: Identifiable {
    let id: String
    let name: String
    var lastModified: Date
    var messages = [Message]()
}
