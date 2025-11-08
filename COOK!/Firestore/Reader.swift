//
//  Reader.swift
//  COOK!
//
//  Created by Benjamin Quackenbush on 10/27/25.
//
/*

import SwiftUI
import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine

class Reader:ObservableObject{
    @Published private(set) var recipies:[Recipe]!
    private var db:Firestore!
    @Published private(set) var user: User 
 
    init(){
        db = Firestore.firestore()
        recipies = []
        user = User()
    }
    
    func createAccount(email: String, password: String) async throws{
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print("Error creating account: \(error.localizedDescription)")
                    return
                }

                print("User created: \(result?.user.uid ?? "")")
            }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            print("Signed in as: \(result?.user.uid ?? "")")
        }
    }
    
    func logOut(){
        do {
            try Auth.auth().signOut()
            print("signed out")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
        
    }
    
    func writeRecipe() {
        db.collection("Global").addDocument(data: ["title": "test"])
    }
    
    func reload(){
        recipies.removeAll()
    }
    
    //returns a list of recipes that fit the given params
    func getRecipies(title: String, ingredients: [String]) async throws -> [Recipe]{
        return [Recipe(name: "placeholder"), Recipe(name: "placeholder")]
    }
    
}

*/
