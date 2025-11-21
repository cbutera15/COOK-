//
//  SignInManager.swift
//  COOK!
//
//  Created by Benjamin Quackenbush on 11/20/25.
//
import Foundation
import Combine

class SignInManager:ObservableObject{
    @Published var isLoading = false
    @Published var signedIn = false
    @Published var operationFailed = false
    @Published var showError = false
    @Published var error = ""
    private var fstore = Reader()
    
    func signIn(email: String, password: String)async{
        isLoading = true
        operationFailed = false
        do{
            let result = try await fstore.signIn(email: email, password: password)
            if result{
                signedIn = true
            }else{
                operationFailed = true
            }
        }catch{
            self.error = error.localizedDescription
            showError = true
            print(error.localizedDescription)
        }
        isLoading = false
    }
    
    func createUser(email: String, password: String) async{
        isLoading = true
        operationFailed = false
        do{
            let result = try await fstore.createAccount(email: email, password: password)
            if result{
                signedIn = true
            }else{
                operationFailed = true
            }
        }catch{
            self.error = error.localizedDescription
            showError = true
            print(error.localizedDescription)
        }
        isLoading = false
    }
    
}
