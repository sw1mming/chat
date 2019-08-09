//
//  DatabaseManager.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/6/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation
import Firebase

final class DatabaseManager {
    
    static let instance = DatabaseManager()
    private init() {}
    
    enum StaticKey {
        static let users = "users"
        static let messages = "messages"
        static let email = "email"
        static let userId = "userId"
        static let userFullName = "userFullName"
    }
    
    static let baseDatabase = Firestore.firestore()
    
    static let usersCollection = DatabaseManager.baseDatabase.collection(StaticKey.users)
    
    static let messagesCollection = DatabaseManager.baseDatabase.collection(StaticKey.messages)
    
    func send(message: MessageModel) {
        guard let recipientId = message.recipientId else { return }
        let id = DatabaseManager.messagesCollection.document().documentID
        let data = ["messageText" : message.text! + " " + id, "messageId" : id, "ownerId" : message.ownerId, "recipientId" : recipientId]
        // .whereField("ownerId", isEqualTo: message.recipientId!)
//        DatabaseManager.messagesCollection.addSnapshotListener { (snap, error) in
//            print()
//        }
//        DatabaseManager.messagesCollection.document(recipientId).collection(StaticKey.messages).document().addSnapshotListener { (snapshot, error) in
//            print()
//        }
        
        DatabaseManager.messagesCollection.document(recipientId).collection(StaticKey.messages).document().setData(data) { error in
            print()
        }
    }
    
    func subscribeMessagesUpdatesFor(userId: String, completion: @escaping (MessageModel?)->()) {
        DatabaseManager.messagesCollection.document(userId).collection(DatabaseManager.StaticKey.messages).addSnapshotListener { (snapshot, error) in
            print()
            let dict = snapshot?.documentChanges.first?.document.data()
            let message = MessageModel(text: dict?["messageText"] as? String,
                                       id: dict?["messageId"] as? String,
                                       ownerId: dict?["ownerId"] as? String,
                                       recipientId: dict?["recipientId"] as? String)
            if message.id == nil {
            } else {
                completion(message)
            }
        }
    }
    
    func loadAllMessagesFor(userId: String, completion: @escaping ([MessageModel])->()) {
        DatabaseManager.messagesCollection.document(userId).collection(DatabaseManager.StaticKey.messages).getDocuments { (snap, error) in
            guard let docs = snap?.documents else { return }
            var messages = [MessageModel]()
            for doc in docs {
                let message = MessageModel(text: doc.data()["messageText"] as? String,
                                           id: doc.data()["messageId"] as? String,
                                           ownerId: doc.data()["ownerId"] as? String,
                                           recipientId: doc.data()["recipientId"] as? String)

                messages.append(message)
            }
            
            completion(messages)
        }
    }
    
    func save(user: DatabaseManager.UserDataModel, completion: @escaping (Error?)->()) {
        let data = [StaticKey.email : user.email,
                    StaticKey.userId : user.id,
                    StaticKey.userFullName: user.fullName]
        DatabaseManager.usersCollection.document(user.id).setData(data, completion: { error in
            completion(error)
        })
    }
    
    func getAllUsers(completion: @escaping ([UserModel])->()) {
        DatabaseManager.usersCollection.getDocuments { (snap, error) in
            guard let docs = snap?.documents else { return }
            
            var users: [UserModel] = []
            for doc in docs {
                let userDictionary = doc.data()
                let user = UserModel(id: userDictionary[StaticKey.userId] as? String,
                                     email: userDictionary[StaticKey.email] as? String,
                                     fullName: userDictionary[StaticKey.userFullName] as? String)
                users.append(user)
            }
            completion(users)
        }
    }
    
    func getUser(id: String, completion: @escaping (UserModel?)->()) {
        DatabaseManager.usersCollection.whereField(StaticKey.userId, isEqualTo: id).getDocuments { (snap, error) in
            guard
                let userDictionary = snap?.documents.first?.data(),
                let userId = userDictionary[StaticKey.userId] as? String,
                let email = userDictionary[StaticKey.email] as? String,
                let name = userDictionary[StaticKey.userFullName] as? String else {
                    completion(nil)
                    return
            }
            let user = UserModel(id: userId,
                                 email: email,
                                 fullName: name)
            completion(user)
        }
    }
    
    func logout(completion: (Bool)->()) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            completion(false)
        }
    }
}

extension DatabaseManager {
    
    struct UserDataModel {
        var fullName: String
        var id: String
        var email: String
    }
    
    struct MessageDataModel {
        var text: String
        var id: String
        var ownerId: String
        var recipientId: String
    }
}
