//
//  DatabaseManager.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/6/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

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
    
    private let baseStorage = Storage.storage()
    
    func send(message: MessageModel, completion: @escaping (Error?)->()) {
        let id = DatabaseManager.messagesCollection.document().documentID
        message.id = id
        guard let encodedData = try? JSONEncoder().encode(message), let data = encodedData.toJSON() else { return }
        DatabaseManager.messagesCollection.document().setData(data, completion: completion)
    }
    
    func subscribeMessagesUpdatesFor(userId: String, completion: @escaping (MessageModel?, Error?)->()) {
        DatabaseManager.messagesCollection.addSnapshotListener { (snapshot, error) in
            guard
                snapshot?.documents.isEmpty == false,
                let document = snapshot?.documentChanges.last?.document,
                let data = document.data().toData() else { return }
            do {
                let message: MessageModel = try JSONDecoder().decode(MessageModel.self, from: data)
                if message.id == nil {
                    completion(nil, CommonError(message: "New message can't be parsed."))
                } else if message.shouldShowWith(currentUserId: AccountController.instance.currentUser?.id, recipientId: userId) {
                    completion(message, nil)
                }
            } catch {
                print("Can't parse subscribed message")
            }
        }
    }
    
    func loadAllMessagesFor(userId: String, completion: @escaping ([MessageModel], Error?)->()) {
        DatabaseManager.messagesCollection.order(by: "createdTimestamp", descending: false).getDocuments { (snap, error) in
            guard let docs = snap?.documents else { return }
            var messages = [MessageModel]()
            for doc in docs {
                guard let data = doc.data().toData() else { continue }
                do {
                    let message: MessageModel = try JSONDecoder().decode(MessageModel.self, from: data)
                    if message.shouldShowWith(currentUserId: AccountController.instance.currentUser?.id, recipientId: userId) {
                        messages.append(message)
                    }
                } catch {
                    print("Can't parse message for list")
                    continue
                }
            }
            completion(messages, error)
        }
    }
    
    func save(user: UserModel, avatarImageData: Data?, completion: @escaping (UserModel, Error?)->()) {
        func saveUser(avatarUrlString: String? = nil) {
            user.avatarUrlString = avatarUrlString
            let encodedData = try? JSONEncoder().encode(user)
            guard let userId = user.id,
                let json = encodedData?.toJSON()
                else { completion(user, CommonError(message: "User doesn't have id.")); return }
            DatabaseManager.usersCollection.document(userId).setData(json, completion: { error in
                completion(user, nil)
            })
        }

        if let avatarData = avatarImageData {
            saveImage(data: avatarData, userId: user.id ?? "") { urlString, error in
                guard let url = urlString else { completion(user, error); return }
                saveUser(avatarUrlString: url)
            }
        } else {
            saveUser()
        }
    }
    
    func saveImage(data: Data, userId: String, completion: @escaping (String?, Error?)->()) {
        let userImagesRef = baseStorage.reference().child("\(userId)_user_avatar.jpg")
        userImagesRef.putData(data, metadata: nil, completion: { metaData, error in
            guard error == nil else { completion(nil, error); return }
            userImagesRef.downloadURL(completion: { url, error in completion(url?.absoluteString, error) })
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
