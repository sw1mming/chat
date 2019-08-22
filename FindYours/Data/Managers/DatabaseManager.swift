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
    
    enum DatabaseKey {
        static let users = "users"
        static let messages = "messages"
    }
    
    static let baseDatabase = Firestore.firestore()
    
    static let usersCollection = DatabaseManager.baseDatabase.collection(DatabaseKey.users)
    
    static let messagesCollection = DatabaseManager.baseDatabase.collection(DatabaseKey.messages)
    
    func send(message: MessageModel, completion: @escaping (Error?)->()) {
        guard let recipientId = message.recipientId else { return }
        let id = DatabaseManager.messagesCollection.document().documentID
        let data = ["createdTimestamp" : message.createdTimestamp,
                    "messageText" : message.text!,
                    "messageId" : id,
                    "ownerId" : message.ownerId,
                    "recipientId" : recipientId] as [String : Any?]

        DatabaseManager.messagesCollection.document().setData(data as [String : Any]) { error in
            completion(error)
        }
    }
    
    func subscribeMessagesUpdatesFor(userId: String, completion: @escaping (MessageModel?, Error?)->()) {
        DatabaseManager.messagesCollection.addSnapshotListener { (snapshot, error) in
            guard
                snapshot?.documents.isEmpty == false,
                let document = snapshot?.documentChanges.last?.document else { return }
            let dict = document.data()
            let message = MessageModel(text: dict["messageText"] as? String,
                                       id: dict["messageId"] as? String,
                                       ownerId: dict["ownerId"] as? String,
                                       recipientId: dict["recipientId"] as? String)
            if message.id == nil {
                completion(message, CommonError(message: "New message can't be parsed."))
            } else if message.shouldShowWith(currentUserId: AccountController.instance.currentUser?.id, recipientId: userId) {
                completion(message, nil)
            }
        }
    }
    
    func loadAllMessagesFor(userId: String, completion: @escaping ([MessageModel], Error?)->()) {
        DatabaseManager.messagesCollection.order(by: "createdTimestamp", descending: false).getDocuments { (snap, error) in
            guard let docs = snap?.documents else { return }
            var messages = [MessageModel]()
            for doc in docs {
                // Codable
                let message = MessageModel(text: doc.data()["messageText"] as? String,
                                           id: doc.data()["messageId"] as? String,
                                           ownerId: doc.data()["ownerId"] as? String,
                                           recipientId: doc.data()["recipientId"] as? String)

                if message.shouldShowWith(currentUserId: AccountController.instance.currentUser?.id, recipientId: userId) {
                    messages.append(message)
                }
            }
            completion(messages, error)
        }
    }
    
    func save(user: UserModel, completion: @escaping (Error?)->()) {
        let encodedData = try? JSONEncoder().encode(user)
        guard let userId = user.id,
            let json = encodedData?.toJSON()
            else { completion(CommonError(message: "User doesn't have id.")); return }

        DatabaseManager.usersCollection.document(userId).setData(json, completion: { error in
            completion(error)
        })
    }
    
    func getAllUsers(completion: @escaping ([UserModel])->()) {
        DatabaseManager.usersCollection.getDocuments { (snap, error) in
            guard let docs = snap?.documents else { return }
            
            var users: [UserModel] = []
            for doc in docs {
                guard let data = doc.data().toData() else { continue }
                do {
                    let user: UserModel = try JSONDecoder().decode(UserModel.self, from: data)
                    users.append(user)
                } catch {
                    print("Can't parse user")
                    continue
                }
                
            }
            completion(users)
        }
    }
    
    func getUser(id: String, completion: @escaping (UserModel?)->()) {
        DatabaseManager.usersCollection.whereField("userId", isEqualTo: id).getDocuments { (snap, error) in
            guard
                let userDictionary = snap?.documents.first?.data(),
                let data = userDictionary.toData() else {
                    completion(nil)
                    return
            }
            do {
                let user: UserModel = try JSONDecoder().decode(UserModel.self, from: data)
                completion(user)
            } catch {
                completion(nil)
            }
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
    
    struct MessageDataModel {
        var text: String
        var id: String
        var ownerId: String
        var recipientId: String
    }
}
