//
//  SignInView.swift
//  COOK!
//
//  Created by Benjamin Quackenbush on 11/20/25.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var appState: AppState
    
    
    var body: some View {
        ZStack{
            if !appState.isLoading{
                VStack{
                    Spacer()

                    Text("COOK!")
                        .foregroundStyle(Color(#colorLiteral(red: 0.7972043157, green: 0.1877797246, blue: 0.8800705075, alpha: 1)))
                        .font(.system(size: 100))
                        .padding([.top], 200)
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
                        Button(action: {
                            Task{
                                await appState.signIn(email: appState.nvEmail, password: appState.nvPassword)
                            }
                        }){
                            Text("Sign In")
                                .foregroundStyle(Color(#colorLiteral(red: 0.7972043157, green: 0.1877797246, blue: 0.8800705075, alpha: 1)))
                        }
                        
                        Button(action: {
                            Task{
                                await appState.createUser(email: appState.nvEmail, password:appState.nvPassword)
                            }
                        }){
                            Text("Create Account")
                                .foregroundStyle(Color(#colorLiteral(red: 0.7972043157, green: 0.1877797246, blue: 0.8800705075, alpha: 1)))
                        }
                    }.font(Font.largeTitle).frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
                        .padding([.bottom], 50)
                    Spacer()
                }.task {
                    if appState.signedIn{
                        appState.selectedTab = .plus
                        appState.loadUserData()
                    }
                }
                .disabled(appState.showError)
            }
            
            if appState.showError && !appState.isLoading{
                ZStack{
                    Rectangle().fill(Color(.white)).opacity(0.5)
                        .frame(width: .infinity ,height: .infinity)
                        
                    VStack{
                        Text(appState.error)
                        Button("Ok"){
                            appState.showError = false
                        }.padding([.bottom],100)
                    }
                }
            }
        }
    }
}

#Preview {
    SignInView().environmentObject(AppState())
}

