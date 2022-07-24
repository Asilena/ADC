//
//  ProfileView.swift
//  ADC
//
//  Created by Elisa Berkane on 22/07/2022.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @EnvironmentObject var model:UserModel

    @Binding var loggedIn: Bool
    
    var body: some View {

        VStack{
            Text("Profile")
                .font(.largeTitle)
            Text(model.userName)
            Button {
                model.fabricList = []
                try! Auth.auth().signOut()
                loggedIn = false
            } label: {
                Text("Log out")
            }

        }

    }
}

