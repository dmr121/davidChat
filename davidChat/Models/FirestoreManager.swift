//
//  FirestoreManager.swift
//  davidChat
//
//  Created by David Rozmajzl on 8/1/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import Foundation
import Firebase

class FirestoreManager {
    let chats = "chats"
    let messages = "messages"
    let db = Firestore.firestore()
    
    func getMessages(completion: @escaping ([Message]) -> ()) {
        db.collection(messages).order(by: "dateTime", descending: false).addSnapshotListener { (snapshot, error) in
            guard let documents = snapshot?.documents, error == nil else {
                print("Error Reading Documents from \(self.chats.capitalized) collection: \"\(error!.localizedDescription)\"")
                return
            }
            
            var messages = [Message]()
            for doc in documents { // Iterating through all the messages
                if let message = self.docToMessage(doc) {
                    messages.append(message)
                }
            }
            
            // Asynchronous return message data
            DispatchQueue.main.async {
                completion(messages)
            }
        }
    }
    
    func sendMessage(message: Message, completion: @escaping () -> ()) {
        let data: [String: Any] = [
            "sender": message.sender,
            "body": message.body,
            "dateTime": Timestamp(date: message.dateTime)
            ]
        
        db.collection(messages).addDocument(data: data) { error in
            if let error = error {
                print("Error Sending Message: \(error)")
                // TODO: Show something on the screen when a messages doesn't send
            }
            completion()
        }
    }
    
    private func docToMessage(_ doc: QueryDocumentSnapshot) -> Message? {
        let id = doc.documentID
        if let body = doc.data()["body"] as? String {
            if let dateTime = doc.data()["dateTime"] as? Timestamp {
                if let sender = doc.data()["sender"] as? String {
                    let message = Message(id: id, sender: sender, body: body, dateTime:
                        dateTime.dateValue())
                    return message
                }
            }
        }
        
        print("Error Decoding Message Object")
        return nil
    }
    
    private func docToChat(_ doc: QueryDocumentSnapshot) -> Chat? {
        let id = doc.documentID
        if let name = doc.data()["name"] as? String {
            if let lastModified = doc.data()["lastModified"] as? Timestamp {
                let chat = Chat(id: id, name: name, lastModified: lastModified.dateValue())
                return chat
            }
        }
        
        print("Error Decoding Chat Object")
        return nil
    }
    
}
