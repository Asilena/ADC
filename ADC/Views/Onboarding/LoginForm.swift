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
            
            VStack {
                
                Text("Se Connecter")
                    .foregroundColor(.white)
                    .padding()
                    .font(.largeTitle)

                
                Form {
                    Section(header: Text("EMAIL")
                        .foregroundColor(.white)
                        .font(.headline)){
                        TextField("Email", text: $email)
                    }
                    Section(header: Text("MOT DE PASSE")
                        .foregroundColor(.white)
                        .font(.headline)){
                            SecureField("Mot de passe", text: $password)
                    }
                    if errorMessage != nil {
                        Section {
                            Text(errorMessage!)
                        }
                    }
                }
                
                ZStack {
                    
                    Rectangle()
                        .cornerRadius(30)
                        .padding(.horizontal)
                        .foregroundColor(Color.mint)
                        .frame(height:50)
                    
                    Button {
                        //Login
                        signIn()
                    } label: {
                        Text("Se Connecter")
                            .foregroundColor(.white)
                    }
                }
                
               
            }
            .background(Color(red: 72/255, green: 72/255, blue: 74/255))
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
