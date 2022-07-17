//
//  FirebaseService.swift
//  Giveth
//
//  Created by David Niño on 05/06/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import UIKit
import FirebaseStorage

final class FirebaseService {
    
    let firestoreDb: Firestore = Firestore.firestore()
    
    init() {}
    
    static func registerUser(registerObject: RegisterUser, registerCompletion: @escaping (Result<User, Error>) -> Void) {
        let email = registerObject.getEmail()
        let pwd = registerObject.getPwd()
        Auth.auth().createUser(withEmail: email, password: pwd) { authDataResult, error in
            if let error = error {
                print("Error found trying to register user... \n\(error.localizedDescription)")
                registerCompletion(.failure(error))
                return
            }
            if let result = authDataResult {
                let user = result.user
                registerCompletion(.success(user))
                return
            }
            print("An unexpected error ocurred in createUser...")
            return
        }
    }
    
    static func logInUser(loginObject: LoginUser, registerCompletion: @escaping (Result<User, Error>) -> Void) {
        let email = loginObject.getEmail()
        let pwd = loginObject.getPwd()
        Auth.auth().signIn(withEmail: email, password: pwd) { authDataResult, error in
            if let error = error {
                print("Error found trying to register user... \n\(error.localizedDescription)")
                registerCompletion(.failure(error))
                return
            }
            if let result = authDataResult {
                let user = result.user
                registerCompletion(.success(user))
                return
            }
            print("An unexpected error ocurred in logInUser...")
            return
        }
    }
    
    static func saveRegisterRestaurant(registerObject: RestaurantUser){
        if let email = registerObject.email {
            Firestore.firestore().collection("Restaurant").document(email).setData([
                "email" : email,
                "password" : registerObject.password ?? "",
                "name" : registerObject.name ?? "",
                "contact" : registerObject.contact ?? "",
                "description": registerObject.description ?? "",
                "address" : registerObject.address ?? "",
                "city" : registerObject.city ?? "",
                "country" : registerObject.country ?? "",
                "zipCode" : registerObject.zipCode ?? "",
                "isCharity" : true,
                "image": registerObject.imageUrl ?? ""
            ])
        }
    }

    
    static func saveRegisterCharity(registerObject: CharityUser) {
        if let email = registerObject.email {
            Firestore.firestore().collection("Charity").document(email).setData([
                "email" : email,
                "password" : registerObject.password ?? "",
                "name" : registerObject.name ?? "",
                "contact" : registerObject.contact ?? "",
                "description": registerObject.description ?? "",
                "address" : registerObject.address ?? "",
                "city" : registerObject.city ?? "",
                "country" : registerObject.country ?? "",
                "zipCode" : registerObject.zipCode ?? "",
                "isCharity" : true,
                "image": registerObject.imageUrl ?? ""
            ])
        }
    }
    
    static func loadCharityUsers(completion: @escaping ([CharityUser]) -> Void) {
        Firestore.firestore().collection("Charity").getDocuments { querySnapshot, error in
            if let query = querySnapshot, error == nil {
                var users = [CharityUser]()
                for documentInQuery in query.documents {
                    let name = documentInQuery.get("name") as? String
                    let email = documentInQuery.get("email") as? String
                    let address = documentInQuery.get("address") as? String
                    let city = documentInQuery.get("city") as? String
                    let country = documentInQuery.get("country") as? String
                    let zipCode = documentInQuery.get("zipCode") as? String
                    let description = documentInQuery.get("description") as? String
                    let contact = documentInQuery.get("contact") as? String
                    let password = documentInQuery.get("password") as? String
                    let imageUrl = documentInQuery.get("image") as? String
                    let user = CharityUser(name: name ?? "", contact: contact ?? "", address: address ?? "", city: city ?? "", country: country ?? "", zipCode: zipCode ?? "", description: description ?? "", email: email ?? "", password: password ?? "", imageUrl: imageUrl ?? "")
                    users.append(user)
                }
                completion(users)
            }
        }
    }
    
    static func loadRestaurantUsers(completion: @escaping ([RestaurantUser]) -> Void) {
        Firestore.firestore().collection("Restaurant").getDocuments { querySnapshot, error in
            if let query = querySnapshot, error == nil {
                var users = [RestaurantUser]()
                for documentInQuery in query.documents {
                    let name = documentInQuery.get("name") as? String
                    let email = documentInQuery.get("email") as? String
                    let address = documentInQuery.get("address") as? String
                    let city = documentInQuery.get("city") as? String
                    let country = documentInQuery.get("country") as? String
                    let zipCode = documentInQuery.get("zipCode") as? String
                    let description = documentInQuery.get("description") as? String
                    let contact = documentInQuery.get("contact") as? String
                    let password = documentInQuery.get("password") as? String
                    let imageUrl = documentInQuery.get("image") as? String
                    let user = RestaurantUser(name: name ?? "", contact: contact ?? "", address: address ?? "", city: city ?? "", country: country ?? "", zipCode: zipCode ?? "", description: description ?? "", email: email ?? "", password: password ?? "", imageUrl: imageUrl ?? "")
                    users.append(user)
                }
                completion(users)
            }
        }
    }
    
    static func loadPosts(completion: @escaping ([UploadData]) -> Void) {
            Firestore.firestore().collection("Post").getDocuments { querySnapshot, error in
                if let query = querySnapshot, error == nil {
                    var posts = [UploadData]()
                    for documentInQuery in query.documents {
                        let name = documentInQuery.get("name") as? String
                        let email = documentInQuery.get("email_id") as? String
                        let contact = documentInQuery.get("contact") as? String
                        let description = documentInQuery.get("description") as? String
                        let address = documentInQuery.get("address") as? String
                        let image_first = documentInQuery.get("image_first") as? String
                        let image_second = documentInQuery.get("image_second") as? String
                        let data = UploadData(name: name ?? "", contact: contact ?? "", description: description ?? "", address: address ?? "", image1: image_first ?? "", image2: image_second ?? "", email: email ?? "")
                        posts.append(data)
                    }
                    completion(posts)
                }
            }
        }
    
    static func uploadData(formObject: UploadData, emailID: String) {
        Firestore.firestore().collection("Post").addDocument(data: [
            "name" : formObject.name ?? "",
            "contact" : formObject.contact ?? "",
            "description": formObject.description ?? "",
            "address" : formObject.address ?? "",
            "image_first": formObject.image1 ?? "",
            "image_second": formObject.image2 ?? "",
            "email_id": emailID
        ])
    }
    
    static func uploadMedia(imageName: String?, image: UIImage?, completion: @escaping (_ url: String?) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference().child(imageName!)
        //let storageRef = FIRStorage.storage().reference().child(imageName)
        if let uploadData = image!.pngData() {
            storageRef.putData(uploadData, metadata: nil) { metadata, error in
                if error != nil {
                    print("error")
                    completion(nil)
                } else {
                    storageRef.downloadURL { url, error in
                        completion(url?.absoluteString)
                                    // success!
                    }
                }
            }
       }
    }
}
