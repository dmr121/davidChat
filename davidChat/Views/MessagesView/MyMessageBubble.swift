//
//  MessageBubble.swift
//  davidChat
//
//  Created by David Rozmajzl on 8/1/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI

struct MyMessageBubble: View {
    var message: Message
    
    var body: some View {
        
        VStack {
            HStack{
                Text(message.body)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .padding(10)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}
