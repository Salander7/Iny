//
//  ProfileInfoManager.swift
//  Iny
//
//  Created by Deniz Dilbilir on 20/03/2024.
//

import Foundation
import GoogleSignIn
import FirebaseAuth

protocol ProfileInfoManagerProtocol {
    func fetchProfilePicAndEmail(completion: @escaping (_ photo: String?, _ email: String?) -> Void)
    func fetchProfileId() -> String?
}

final class ProfileInfoManager: ProfileInfoManagerProtocol {
    func fetchProfilePicAndEmail(completion: @escaping (_ photo: String?, _ email: String?) -> Void) {
        if let user = Auth.auth().currentUser {
            let profileImageURL = user.photoURL
            completion(profileImageURL?.absoluteString, user.email)
        } else {
            completion(nil, nil)
        }
    }
    
    func fetchProfileId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    

}
