//
//  UserMessageBubble.swift
//  davidChat
//
//  Created by David Rozmajzl on 8/1/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI

struct UserMessageBubble: View {
    
    var message: Message
    
    var body: some View {
        VStack {
            HStack {
                Text(message.sender)
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.bottom, 4)
            
            HStack{
                Text(message.body)
                Spacer()
            }
        }
        .padding(10)
        .background(Color(UIColor.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}
