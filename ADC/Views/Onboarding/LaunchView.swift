//
//  LaunchView.swift
//  ADC
//
//  Created by Elisa Berkane on 22/07/2022.
//

import SwiftUI
import FirebaseAuth

struct LaunchView: View {
    
    @StateObject var model = UserModel()


    @State var loggedIn = false
    @State var loginFormShowing = false
    @State var createFormShowing = false
    
    var body: some View {
        
        // Check if user is logged in and show appropriate view
        if !loggedIn {
            
            VStack (spacing:20){
                
                Spacer()
                
                Text("Bienvenue")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Spacer()
                
                // Sign in view
                ZStack {
                    
                    Rectangle()
                        .cornerRadius(30)
                        .padding(.horizontal)
                        .foregroundColor(Color(red: 72/255, green: 72/255, blue: 74/255))
                        .frame(height:50)
                    
                    Button {
                        //Show login form
                        loginFormShowing = true
                    } label: {
                        Text("Se Connecter")
                            .foregroundColor(.white)
                    }
                    .sheet(isPresented: $loginFormShowing, onDismiss: checkLogin) {
                        LoginForm(formShowing: $loginFormShowing)
                            .onAppear(perform: {UITableView.appearance().backgroundColor = .clear})
                            .onDisappear {UITableView.appearance().backgroundColor = .systemGroupedBackground}
                    }
                }
                
                // Create account
                
                ZStack {
                    
                    Rectangle()
                        .cornerRadius(30)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .frame(height:50)
                    
                    Button {
                        createFormShowing = true
                    } label: {
                        Text("Créer un Compte")
                            .foregroundColor(Color(red: 72/255, green: 72/255, blue: 74/255))
                    }
                    .sheet(isPresented: $createFormShowing, onDismiss: checkLogin) {
                        CreateAccountForm(formShowing: $createFormShowing)
                            .onAppear(perform: {UITableView.appearance().backgroundColor = .clear})
                            .onDisappear {UITableView.appearance().backgroundColor = .systemGroupedBackground}
                    }
                    
                }
                Spacer()
                
                
                
                
            }
            .background(Color.mint)
            .ignoresSafeArea()
            .onAppear {
                checkLogin()
            }
        }
        else {
            
            // Show logged in view
            TabViews(loggedIn: $loggedIn)
                .onAppear(perform: model.getUserData)
                .onAppear(perform: model.getFabricData)
                .onDisappear {
                    model.fabricDataListener?.remove()
                    model.userDataListener?.remove()
                }
                .environmentObject(model)
        }
        
    }
    
    func checkLogin() {
        
        loggedIn = Auth.auth().currentUser == nil ? false : true
        
    }
    
}
