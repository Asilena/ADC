//
//  CreateAccountForm.swift
//  ADC
//
//  Created by Elisa Berkane on 22/07/2022.
//

import SwiftUI
import FirebaseAuth

struct CreateAccountForm: View {
    
    @Binding var formShowing: Bool
    
    @State private var email:String = ""
    @State private var name:String = ""
    @State private var password:String = ""
    
    @State private var errorMessage:String?

    var body: some View {

        NavigationView {
            
            Form{
                
                Section {
                TextField("Email", text: $email)
                TextField("Name", text: $name)
                SecureField("Password", text: $password)
                }
                
                if errorMessage != nil {
                    Section {
                        Text(errorMessage!)
                    }
                }
                
                
                Button {
                    // Create account
                    createAccount()
                } label: {
                    Text("Create account")
                }

                
            }
            
        }
        .navigationBarTitle("Create an Account")

    }
    
    func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            DispatchQueue.main.async {
                if error == nil {
                    // Dismiss the form
                    formShowing = false
                }
                else {
                    errorMessage = error!.localizedDescription
                }
            }
            
           
        }
    }
}

