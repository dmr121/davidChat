//
//  AuthTextField.swift
//  davidChat
//
//  Created by David Rozmajzl on 7/31/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI

struct EmailTextField: View {
    
    @Binding var input: String
    
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .padding(.horizontal)
                .foregroundColor(Color(UIColor.darkGray))
            
            ZStack (alignment: .leading) {
                if input.isEmpty {
                    Text("Email Address")
                        .foregroundColor(.gray)
                }
                
                TextField("", text: $input)
                    .autocapitalization(.none)
                    .frame(height: 50)
            }
        }
        .background(Color(UIColor.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
