//
//  LaunchView.swift
//  ADC
//
//  Created by Elisa Berkane on 22/07/2022.
//

import SwiftUI
import FirebaseAuth

struct LaunchView: View {
    
    @State var loggedIn = false
    @State var loginFormShowing = false
    @State var createFormShowing = false
    
    var body: some View {
        
        // Check if user is logged in and show appropriate view
        if !loggedIn {
            
            VStack (spacing:20){
                
                // Sign in view
                Button {
                    //Show login form
                    loginFormShowing = true
                } label: {
                    Text("sign in")
                }
                .sheet(isPresented: $loginFormShowing, onDismiss: checkLogin) {
                    LoginForm(formShowing: $loginFormShowing)
                }
                
                // Create account
                Button {
                    createFormShowing = true
                } label: {
                    Text("Create account")
                }
                .sheet(isPresented: $createFormShowing, onDismiss: checkLogin) {
                    CreateAccountForm(formShowing: $createFormShowing)
                }

                
                
            }
            .onAppear {
                checkLogin()
            }
        }
        else {
            
            // Show logged in view
            TabViews(loggedIn: $loggedIn)
        }
        
    }
    
    func checkLogin() {
        
        loggedIn = Auth.auth().currentUser == nil ? false : true
        
    }
    
}
