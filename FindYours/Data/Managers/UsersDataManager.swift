//
//  UsersDataManager.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/27/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation
import FirebaseStorage
import Firebase

final class UsersDataManager: BaseManager {
    
    static let instance = UsersDataManager()
    private override init() {}

    private let usersCollection = BaseManager.baseDatabase.collection(DatabaseKey.users)
    private let baseStorage = Storage.storage()
    
    func save(user: UserModel, avatarImageData: Data?, completion: @escaping (UserModel, Error?)->()) {
        func saveUser(avatarUrlString: String? = nil) {
            user.avatarUrlString = avatarUrlString
            let encodedData = try? JSONEncoder().encode(user)
            guard let userId = user.id,
                let json = encodedData?.toJSON()
                else { completion(user, CommonError(message: "User doesn't have id.")); return }
            usersCollection.document(userId).setData(json, completion: { error in
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
        usersCollection.getDocuments { (snap, error) in
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
        usersCollection.whereField("userId", isEqualTo: id).getDocuments { (snap, error) in
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
