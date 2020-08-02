//
//  Mesage.swift
//  davidChat
//
//  Created by David Rozmajzl on 8/1/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Message: Identifiable {
    let id: String
    let sender: String
    let body: String
    let dateTime: Date
}

