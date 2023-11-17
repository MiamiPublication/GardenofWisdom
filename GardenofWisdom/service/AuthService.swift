//
//  AuthService.swift
//  GardenofWisdom
//
//  Created by Miami Jaboori on 2023-11-26.
//

import FirebaseAuth

class AuthService{
    static let sharedAuthService = AuthService() //Singleton
    
    func registerUser(email: String, password: String, completion: @escaping (Bool, Error?) -> Void ){
        Auth.auth().createUser(withEmail: email, password: password){result, error in
            if let error = error {
                completion(false, error)
            }else{
                completion(true, nil)
            }
        }
    }
    
    func loginUser(email: String, password: String,completion: @escaping (Bool, Error?) -> Void ){
        Auth.auth().signIn(withEmail: email,password: password) {result, error in
            if let error = error {
                completion(false, error)
            }else{
                completion(true, nil)
            }
        }
    }
    
    func signOutUser(completion: @escaping (Bool, Error?) -> Void ){
        do {
            try Auth.auth().signOut()
            completion(true, nil)
        }catch let signOutError as NSError {
            completion(false, signOutError)
        }
    }
    
}
