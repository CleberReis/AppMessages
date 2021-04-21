//
//  Service.swift
//  Messages
//
//  Created by Cleber Reis on 15/04/21.
//

import Foundation
import Firebase

struct Service {
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        COLLECTION_USERS.getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                completion(users)
                
            })
        }
    }
    
    static func fetchUser(withUID uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictonary = snapshot?.data() else { return }
            let user = User(dictionary: dictonary)
            completion(user)
        }
    }
    
    static func fetchConversations(completion: @escaping([Conversation]) -> Void) {
        var conversations = [Conversation]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages").order(by: "timestamp")
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                let dictonary = change.document.data()
                let message = Message(dictionary: dictonary)
                
                self.fetchUser(withUID: message.toID) { user in
                    let conversation = Conversation(user: user, message: message)
                    conversations.append(conversation)
                    completion(conversations)
                }
                
            })
        }
    }
    
    static func fetchMessages(forUser user: User, completion: @escaping([Message]) -> Void) {
        var messages = [Message]()
        guard let currentID = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(currentID).collection(user.uid).order(by: "timestamp")
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    messages.append(Message(dictionary: dictionary))
                    completion(messages)
                }
            })
        }
    }
    
    static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        let data = ["text": message,
                    "fromID": currentUID,
                    "toID": user.uid,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        COLLECTION_MESSAGES.document(currentUID).collection(user.uid).addDocument(data: data) { _ in
            
            COLLECTION_MESSAGES.document(user.uid).collection(currentUID).addDocument(data: data, completion: completion)
            COLLECTION_MESSAGES.document(currentUID).collection("recent-messages").document(user.uid).setData(data)
            COLLECTION_MESSAGES.document(user.uid).collection("recent-messages").document(currentUID).setData(data)
            
        }
    }
    
}
