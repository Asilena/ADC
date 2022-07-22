//
//  ProfileView.swift
//  ADC
//
//  Created by Elisa Berkane on 22/07/2022.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @Binding var loggedIn: Bool
    
    var body: some View {

        VStack{
            Text("Welcome")
            Button {
                try! Auth.auth().signOut()
                loggedIn = false
            } label: {
                Text("Log out")
            }

        }

    }
}

