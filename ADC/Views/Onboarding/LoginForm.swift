//
//  LoginForm.swift
//  ADC
//
//  Created by Elisa Berkane on 22/07/2022.
//

import SwiftUI
import FirebaseAuth

struct LoginForm: View {
    
    @Binding var formShowing: Bool
    
    @State private var email: String = ""
    @State private var password = ""
    @State private var errorMessage: String?
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Section{
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                if errorMessage != nil {
                    Section {
                        Text(errorMessage!)
                    }
                }
                
                Button {
                    //Login
                    signIn()
                } label: {
                    Text("Sign in")
                }
                
            }
            .navigationBarTitle("Sign In")
        }
        
    }
    
    func signIn() {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            DispatchQueue.main.async {
                if error == nil {
                    //Dismiss this sheet
                    formShowing = false
                }
                else {
                    // If there is an issue with logging in
                    errorMessage = error!.localizedDescription
                }
            }
            
        }
        
    }
}
