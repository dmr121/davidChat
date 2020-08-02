//
//  MessagesView.swift
//  davidChat
//
//  Created by David Rozmajzl on 8/1/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI

struct MessagesView: View {
    
    @ObservedObject private var messageManager = MessageManager()
    @EnvironmentObject var loginManager: LoginManager
    @State var messageBody = ""
    @State var indexPathToSetVisible: IndexPath?
    @State var offset: CGFloat = 0
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        VStack {
            List(messageManager.messages) { message in
                if message.sender == self.loginManager.username {
                    HStack {
                        Spacer()
                        MyMessageBubble(message: message)
                            .frame(width: self.screenWidth*0.55)
                    }
                } else {
                    UserMessageBubble(message: message)
                        .frame(width: self.screenWidth*0.55)
                }
            }
            .onTapGesture {
                self.hideKeyboard()
            }
            .onAppear {
                UITableView.appearance().separatorStyle = .none
            }
            .overlay(
                ScrollManagerView(indexPathToSetVisible: $indexPathToSetVisible)
                    .allowsHitTesting(false).frame(width: 0, height: 0)
            )
                .navigationBarTitle("Messages", displayMode: .inline)
                .navigationBarItems(
                    trailing:
                    HStack {
                        
                        Button(action: {
                            self.indexPathToSetVisible = IndexPath(
                                row: self.messageManager.messages.count - 1, section: 0
                            )
                        }) {
                            Text("BOTTOM")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                        
                        NavigationLink(destination: SettingsView().environmentObject(loginManager)) {
                            Image(systemName: "gear")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(Color(UIColor.systemGray2))
                                .padding([.leading, .bottom, .top])
                        }
                        .isDetailLink(false)
                    }
            )
            
            
            VStack (spacing: 0) {
                Rectangle().foregroundColor(Color(UIColor.systemGray5))
                    .frame(maxWidth: .infinity)
                    .frame(height: 2)
                    .padding(.top, -8)
                
                HStack (alignment: .top) {
                    MultilineTextFieldView("", text: $messageBody, characterLimit: nil)
                        .animation(.easeInOut(duration: 0.1))
                        .padding(.horizontal)
                        .padding(.top, 4)
                        .foregroundColor(.red)
                        .background(Color(UIColor.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .padding([.leading, .top, .bottom])
                    
                    Button(action: {
                        if self.messageBody.count > 0 {
                            self.messageManager.sendMessage(sender: self.loginManager.username ?? "Me", body: self.messageBody, completion: {
                                self.messageBody = ""
                                self.indexPathToSetVisible = IndexPath(
                                    row: self.messageManager.messages.count - 1, section: 0
                                )
                            })
                        }
                    }) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .padding([.top, .trailing])
                            .padding(.top, 12)
                    }
                    .offset(x: messageBody.count > 0 ? 0 : 100, y: 0)
                    .animation(.spring())
                }
            }
        }
        .offset(x: 0, y: -offset)
        .animation(.spring())
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main, using: { notif in
                let value = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                self.offset = height
            })
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main, using: { _ in
                self.offset = 0
            })
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIView {
    
    func subview<T>(of type: T.Type) -> T? {
        return subviews.compactMap { $0 as? T ?? $0.subview(of: type) }.first
    }
    
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
