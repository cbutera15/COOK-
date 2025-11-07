//
//  User.swift
//  test
//
//  Created by Benjamin Quackenbush on 11/6/25.
//
import SwiftUI

class User: AnyObject{
    private var email: String
    private var calendar: [[String]]//Each row is a time slot moring, evening, and afternoon
    private var customRecipies: [Recipe]
    
    init(){
        email = ""
        calendar = []
        customRecipies = []
    }
    
    func setEmail(_ email: String){
        self.email = email
    }
    
}
