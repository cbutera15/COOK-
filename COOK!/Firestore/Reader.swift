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
    
    func createAccount(email: String, password: String) async throws -> Bool{
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
        
        return user.id != "N/A"
        
    }
    
    func signIn(email: String, password: String) async throws -> Bool{
        if user.id != "N/A"{
            return false
        }
        user.rmAll()
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            guard let result = result else {
                return
            }
            print("Signed in as: \(result.user.uid)")
            
            self.user.setId(result.user.uid)
            self.user.setEmail(result.user.email!)
        }

        //check if sign in was succsessful
        if user.id == "N/A"{
            return false
        }
        
        
        //load all user data into the user object
        let favRef = try await db.collection("Users/\(user.id)/user_favorites").getDocuments()
        for doc in favRef.documents{
            user.addFav(try ssToR(doc))
        }
        
        let customeRef = try await db.collection("Users/\(user.id)/user_recipes").getDocuments()
        for doc in customeRef.documents{
            user.addCustom(try ssToR(doc))
        }
        
        return true
        
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
    
    func addUserRecipe(_ recipe: Recipe){
        if user.id == "N/A"{
            print("no user signed in")
            return
        }
        let collection = db.collection("Users").document(user.id).collection("user_recipes")
        writeRecipeTo(cr: collection, recipe: recipe)
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
        let collection = db.collection("Users").document(user.id).collection("user_favorites")
        writeRecipeTo(cr: collection, recipe: recipe)
        
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
    
    func addToPantry(_ ingredient:Ingredient){
        let doc = db.collection("Users/\(user.id)/pantry").document(ingredient.id)
        doc.setData([
            "name": ingredient.name,
            "quantity": ingredient.quantity,
            "unit": ingredient.unit.name.name
        ])
    }
    
    func rmFromPantry(_ ingredient:Ingredient){
        db.collection("Users/\(user.id)/pantry").document(ingredient.id).delete()
    }
    
    //writes the given recipe to the given collection
    func writeRecipeTo(cr: CollectionReference, recipe: Recipe) {
        if user.id == "N/A"{
            print("no user signed in")
            return
        }
        
        let doc = cr.document(recipe.id)
        doc.setData([
            "id": recipe.id,
            "title": recipe.name,
            "instructions": recipe.instructions,
            "description": recipe.description
        ])
        
        var types: [String] = []
        var amounts: [Int] = []
        var units: [String] = []
        for ingredient in recipe.ingredients{
            units.append(ingredient.unit.name.name)
            types.append(ingredient.name)
            amounts.append(ingredient.quantity)
        }
        
        doc.updateData([
            "ingredients": types,
            "amounts": amounts,
            "units": units
        ])
    }
    
    //Snapshot to Recipe(ssToR): takes a QueryDocumentSnapshot and returns a single recipe obj
    func ssToR(_ query: QueryDocumentSnapshot) throws -> Recipe{
        let data = query.data()
        var recipe = Recipe(name: data["title"] as? String ?? "")
        recipe.setId(query.get("id") as? String ?? "")
        recipe.instructions = query.get("instructions") as? String ?? ""
        
        if recipe.id == "" || recipe.name == ""{
            throw NSError(domain: "MyApp", code: 1, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])
        }
        
        let amounts = query.get("amounts") as? [Int] ?? []
        let units = query.get("units") as? [String] ?? []
        let names = query.get("ingredients") as? [String] ?? []
        
        if names.count < 1{
            throw NSError(domain: "MyApp", code: 1, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])
        }
        
        if names.count != units.count && units.count != amounts.count{
            throw NSError(domain: "MyApp", code: 1, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])
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
                return try ssToR(snapshot.documents.first!)
            }
        }

        if title != nil{
            let snapshot = try await reference.whereField("title", isEqualTo: title!).getDocuments()
            
            if snapshot.count == 1{
                return try ssToR(snapshot.documents.first!)
            }
        }

        return Recipe(name:"Fail")
    }
    
    //will search for any recipes that contain words in the title or ingredients
    func approxSearch(global: Bool = true, title: String? = nil, ingredients: [String]? = nil) async throws -> [Recipe]{
        var reference = db.collection("App")
        if !global{
            if user.id != "N/A"{
                reference = db.collection("Users").document(user.id).collection("user_recipes")
            }
        }
        
                
        var recipes: [Recipe]?
        if title != nil{
            let title: [String] = title?.split(separator: " ") as! [String]
            let documents = try await reference.whereField("title keywords", arrayContainsAny: title).getDocuments().documents
            for doc in documents{
                recipes?.append(try ssToR(doc))
            }
        }
        if recipes != nil{
            return recipes!
        }
        
        if ingredients != nil{
            let documents = try await reference.whereField("title keywords", arrayContainsAny: ingredients!).getDocuments().documents
            for doc in documents{
                recipes?.append(try ssToR(doc))
            }
        }
        
        if recipes != nil{
            return recipes!
        }else{
            return []
        }
    }
        
}


