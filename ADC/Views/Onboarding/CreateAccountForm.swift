//
//  CreateAccountForm.swift
//  ADC
//
//  Created by Elisa Berkane on 22/07/2022.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct CreateAccountForm: View {
    
    @Binding var formShowing: Bool
    
    @State private var email:String = ""
    @State private var name:String = ""
    @State private var password:String = ""
    
    @State private var errorMessage:String?
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                Text("Créer un Compte")
                    .foregroundColor(.white)
                    .padding()
                    .font(.largeTitle)
                
                Form{
                    
                    Section(header: Text("EMAIL")
                        .foregroundColor(.white)
                        .font(.headline)){
                            TextField("Email", text: $email)
                        }
                    Section(header: Text("NOM")
                        .foregroundColor(.white)
                        .font(.headline)){
                            TextField("Nom complet", text: $name)
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
            
            .background(Color(red: 72/255, green: 72/255, blue: 74/255))
            
            ZStack {
                
                Rectangle()
                    .cornerRadius(30)
                    .padding(.horizontal)
                    .foregroundColor(Color.mint)
                    .frame(height:50)
                
                Button {
                    //Create account
                    createAccount()
                } label: {
                    Text("Créer un compte")
                        .foregroundColor(.white)
                }
            }
            }
            .background(Color(red: 72/255, green: 72/255, blue: 74/255))

        }
        
    }
    
    
    func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            DispatchQueue.main.async {
                if error == nil {
                    // Save user data
                    let user = Auth.auth().currentUser
                    let db = Firestore.firestore()
                    let ref = db.collection("users").document(user!.uid)
                    
                    ref.setData(["name":name], merge: true)
                    
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

