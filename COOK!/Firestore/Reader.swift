//
//  Reader.swift
//  COOK!
//
//  Created by Benjamin Quackenbush on 10/27/25.
//
import SwiftUI
import Foundation
import FirebaseFirestore
import Combine

class Reader:ObservableObject{
    @Published private(set) var recipies:[Recipe]!
    private var db:Firestore!
    public var x:Int
    init(){
        db = Firestore.firestore()
        recipies = []
        x = 0
    }
    
    func reload(){
        recipies.removeAll()
    }
    
    func getRecipies() async throws{
        let query = try await db.collection("Global").getDocuments()
        for doc in query.documents{
            let data = doc.data()
            if let id = data["id"]{
                x = id as! Int
                print("changed")
            }else{
                print("not changed")
            }
        }
    }
    
}


