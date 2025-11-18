//
//  Reader.swift
//  COOK!
//
//  Created by Benjamin Quackenbush on 10/27/25.
//
import SwiftUI
import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine
import FirebaseCore

class Reader:ObservableObject{
    private var db:Firestore!
    @Published private(set) var user: User 
 
    init(){
        db = Firestore.firestore()
        user = User()
    }
    
    func createAccount(email: String, password: String) async throws{
        user.rmAll()
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error creating account: \(error.localizedDescription)")
                return
            }
            print("User created: \(result?.user.uid ?? "")")
            self.user.setId(result!.user.uid)
            self.user.setEmail(result!.user.email!)
        }
        
    }
    
    func signIn(email: String, password: String) async throws{
        if user.id != "N/A"{
            return
        }
        user.rmAll()
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            print("Signed in as: \(result?.user.uid ?? "")")
            self.user.setId(result!.user.uid)
            self.user.setEmail(result!.user.email!)
        }
        
        //load all user data into the user object
        let userFav = try await db.collection("Users").document(user.id).collection("user_favorites").getDocuments().documents
        for doc in userFav{
            user.addFav(ssToR(doc))
        }
        
        let userCustom = try await db.collection("Users").document(user.id).collection("user_recipes").getDocuments().documents
        for doc in userCustom{
            user.addCustom(ssToR(doc))
        }
    }
    
    func logOut(){
        if user.id == "N/A"{
            print("no user signed in")
            return
        }
        do {
            try Auth.auth().signOut()
            user.rmAll()//wipes user data
            print("signed out")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
        
    }
    
    
    
    func writeRecipeUser(_ recipe: Recipe) {
        if user.id == "N/A"{
            print("no user signed in")
            return
        }
        
        let doc = db.collection("Users").document(user.id).collection("user_recipes").document(recipe.id)
        doc.setData([
            "name": recipe.name,
            "instructions": recipe.instructions
        ])
        
        for ingredient in recipe.ingredients{
            doc.updateData([
                "ingredients": FieldValue.arrayUnion([ingredient.name]),
                "amounts": FieldValue.arrayUnion([ingredient.quantity]),
                "units": FieldValue.arrayUnion([ingredient.unit])
            ])
        }
    }
    
    //removes a users custom recipe by id
    func rmUserRecipe(_ id: String){
        if user.id == "N/A"{
            print("no user signed in")
            return
        }
        //removes from firestore
        db.collection("Users").document(user.id).collection("user_recipes").document(id).delete()
        
        //removes from user obj
        user.rmCustom(id)
    }
    
    //adds a favorite recipe by id
    //recipe must exist in the Apps sections of firestore
    func addFav(_ recipe:Recipe){
        if user.id == "N/A"{
            print("no user signed in")
            return
        }
        
        //adds the id to the collection makes sure that no duplicates exists
        db.collection("Users").document(user.id).collection("user_favorites").document(recipe.id)
        
        user.addFav(recipe)
    }
    
    //removes the favorite recipe by id
    func rmFav(_ id: String){
        if user.id == "N/A"{
            print("no user signed in")
            return
        }
        //removes from firestore
        db.collection("Users").document(user.id).collection("user_favorites").document(id).delete()
        
        user.rmFav(id)
    }
    
    //Snapshot to Recipe(ssToR): takes a QueryDocumentSnapshot and returns a single recipe obj
    func ssToR(_ query: QueryDocumentSnapshot) -> Recipe{
        var recipe = Recipe(name: query.get("title") as! String)
        recipe.setId(query.get("id") as! String)
        recipe.instructions = query.get("instructions") as! String
        
        let amounts = query.get("amounts") as? [String] ?? []
        let units = query.get("units") as? [String] ?? []
        let names = query.get("types") as? [String] ?? []
        
        if names.count < 1{
            return Recipe(name: "Fail")
        }
        
        for i in 0...names.count-1{
            recipe.addIngredient(Ingredient(name: names[i], quantity: Int(amounts[i]) ?? -1, unit: Ingredient.Unit(rawValue: units[i]) ?? .none))
        }
        
        return recipe
        
    }
    
    //will first try and search an exact match in the id if given. Will then try the same with title
    func exactSearch(global: Bool = true, id: String? = nil, title: String? = nil) async throws -> Recipe{
        var reference = db.collection("App")
        if !global{
            if user.id != "N/A"{
                reference = db.collection("Users").document(user.id).collection("user_recipes")
            }
        }
        if id != nil{
            let snapshot = try await reference.whereField("id", isEqualTo: id!).getDocuments()
            
            if snapshot.count == 1{
                return ssToR(snapshot.documents.first!)
            }
        }

        if title != nil{
            let snapshot = try await reference.whereField("title", isEqualTo: title!).getDocuments()
            
            if snapshot.count == 1{
                return ssToR(snapshot.documents.first!)
            }
        }

        return Recipe(name:"Fail")
    }
    
    //will search for any recipes that contain words in the title or ingredients
    func approxSearch(global: Bool = true, title: String? = nil, ingredients: [String]? = nil) -> [Recipe]{
        var reference = db.collection("App")
        if !global{
            if user.id != "N/A"{
                reference = db.collection("Users").document(user.id).collection("user_recipes")
            }
        }
        
                
        var recipes: [Recipe]?
        if title != nil{
            let title: [String] = title?.split(separator: " ") as! [String]
            let _: Void = reference.whereField("title keywords", arrayContainsAny: title).getDocuments(){(snapshot, error) in
                if let snapshot = snapshot, snapshot.count > 1 {
                    for doc in snapshot.documents{
                        recipes?.append(self.ssToR(doc))
                    }
                }
            }
        }
        if recipes != nil{
            return recipes!
        }
        
        if ingredients != nil{
            let _: Void = reference.whereField("title keywords", arrayContainsAny: ingredients!).getDocuments(){(snapshot, error) in
                if let snapshot = snapshot, snapshot.count > 1 {
                    for doc in snapshot.documents{
                        recipes?.append(self.ssToR(doc))
                    }
                }
            }
        }
        
        if recipes != nil{
            return recipes!
        }else{
            return []
        }
    }
        
}


