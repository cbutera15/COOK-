//
//  SignInView.swift
//  COOK!
//
//  Created by Benjamin Quackenbush on 11/20/25.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var manager = SignInManager()
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Text("COOK!")
                    .foregroundStyle(Color(#colorLiteral(red: 0.7972043157, green: 0.1877797246, blue: 0.8800705075, alpha: 1)))
                    .font(.system(size: 100))
                    .padding([.bottom], 50)
                VStack{
                    Image(systemName: "person.crop.circle")
                        .foregroundStyle(Color(#colorLiteral(red: 0.7972043157, green: 0.1877797246, blue: 0.8800705075, alpha: 1)))
                        .padding()
                    
                    TextField("Email", text: $appState.nvEmail)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .textInputAutocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .multilineTextAlignment(.center)
                        .frame(width:UIScreen.main.bounds.width * 0.8)
                    
                    TextField("Password", text: $appState.nvPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .textInputAutocapitalization(.none)
                        .multilineTextAlignment(.center)
                        .frame(width:UIScreen.main.bounds.width * 0.8)
                    VStack{
                        
                    }
                    Button(action: {
                        Task{
                            await manager.signIn(email: appState.nvEmail, password: appState.nvPassword)
                        }
                    }){
                        Text("Sign In")
                            .foregroundStyle(Color(#colorLiteral(red: 0.7972043157, green: 0.1877797246, blue: 0.8800705075, alpha: 1)))
                    }
                    
                    Button(action: {
                        Task{
                            await manager.createUser(email: appState.nvEmail, password:appState.nvPassword)

                        }
                    }){
                        Text("Create Account")
                            .foregroundStyle(Color(#colorLiteral(red: 0.7972043157, green: 0.1877797246, blue: 0.8800705075, alpha: 1)))
                    }
                }.font(Font.largeTitle.bold())
                Spacer()
            }
            if manager.operationFailed{
                ZStack{
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width * 0.5,height: UIScreen.main.bounds.height * 0.5)
                    VStack{
                        Text(manager.error)
                        Button("Ok"){
                            manager.operationFailed = false
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    SignInView().environmentObject(AppState())
}

