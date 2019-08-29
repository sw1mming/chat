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

final class MessagesDatabaseManager: BaseManager {
    
    static let instance = MessagesDatabaseManager()
    private override init() {}
    
    static let messagesCollection = BaseManager.baseDatabase.collection(DatabaseKey.messages)
    
    private let baseStorage = Storage.storage()
    
    func send(message: MessageModel, completion: @escaping (Error?)->()) {
        let id = MessagesDatabaseManager.messagesCollection.document().documentID
        message.id = id
        guard let encodedData = try? JSONEncoder().encode(message), let data = encodedData.toJSON() else { return }
        MessagesDatabaseManager.messagesCollection.document().setData(data, completion: completion)
    }
    
    func subscribeMessagesUpdatesFor(userId: String, completion: @escaping (MessageModel?, Error?)->()) {
        MessagesDatabaseManager.messagesCollection.addSnapshotListener { (snapshot, error) in
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
        MessagesDatabaseManager.messagesCollection.order(by: "createdTimestamp", descending: false).getDocuments { (snap, error) in
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
}
