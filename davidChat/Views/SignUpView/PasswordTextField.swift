//
//  PasswordTextField.swift
//  davidChat
//
//  Created by David Rozmajzl on 7/31/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI

struct PasswordTextField: View {
    
    @Binding var input: String
    var placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "lock.fill")
                .padding(.horizontal)
                .foregroundColor(Color(UIColor.darkGray))
            
            ZStack (alignment: .leading) {
                if input.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                }
                
                SecureField("", text: $input)
                    .textContentType(.newPassword)
                    .frame(height: 50)
            }
        }
        .background(Color(UIColor.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
