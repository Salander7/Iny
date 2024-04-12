//
//  AuthManager.swift
//  Iny
//
//  Created by Deniz Dilbilir on 25/03/2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

protocol AuthManagerProtocol {
    func signIn(email: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void)
    func resetPassword(with email: String, completion: @escaping (Result<Void, FirebaseError>) -> Void)
    func signOut(completion: (Result<Void, FirebaseError>) -> Void)
    func googleSignIn(completion: @escaping (Result<Void, FirebaseError>) -> Void)
}

final class AuthManager {
    private let auth = Auth.auth()
}
//Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
//  guard let strongSelf = self else { return }
//  // ...
//}

extension AuthManager: AuthManagerProtocol {
    func signIn(email: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        auth.signIn(withEmail: email, password: password) {  (result, error) in
            if let error {
                debugPrint(error)
                completion(.failure(.signInError))
            } else {
                if let user = result?.user, user.isEmailVerified {
                    completion(.success(()))
                } else {
                    completion(.failure(.emailNotVerifiedError))
                }
            }
        }
    }
    
    //    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
    //      // ...
    //    }
    //    Auth.auth().currentUser?.sendEmailVerification { error in
    //      // ...
    //    }
    func signUp(email: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error {
                debugPrint(error)
                completion(.failure(.signUpError))
            } else {
                result?.user.sendEmailVerification { error in
                    if let error {
                        debugPrint(error)
                        completion(.failure(.sendEmailError))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
    //    Auth.auth().sendPasswordReset(withEmail: email) { error in
    //      // ...
    //    }
    func resetPassword(with email: String, completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        auth.sendPasswordReset(withEmail: email) { error in
            if let error {
                debugPrint(error)
                completion(.failure(.resetPasswordError))
            } else {
                completion(.success(()))
            }
        }
    }
    //    let firebaseAuth = Auth.auth()
    //    do {
    //      try firebaseAuth.signOut()
    //    } catch let signOutError as NSError {
    //      print("Error signing out: %@", signOutError)
    //    }
    func signOut(completion: (Result<Void, FirebaseError>) -> Void) {
        do {
            try auth.signOut()
            completion(.success(()))
        } catch {
            completion(.failure(.signOutError))
        }
    }
    
    
 
    func googleSignIn(completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            guard let self else { return }
            if let error {
                debugPrint(error)
            } else {
                guard let user = result?.user,
                      let idToken = user.idToken?.tokenString
                else {
                    return
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: user.accessToken.tokenString)
                
                self.auth.signIn(with: credential) { _, error in
                    if let error {
                        debugPrint(error)
                        completion(.failure(.signInWithGoogleError))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
}
