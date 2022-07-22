//
//  HomeView.swift
//  ADC
//
//  Created by Elisa Berkane on 14/07/2022.
//

import SwiftUI



struct TabViews: View {
    
    @EnvironmentObject var model:FabricModel
    @Binding var loggedIn: Bool

    var body: some View {
        
        TabView{

            HomeView()
                .tabItem{
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                }
            
            FabricListView()
                .tabItem{
                    VStack {
                        Image(systemName: "scissors")
                        Text("Tissus")
                    }
                }

            PatternListView()
                .tabItem{
                    VStack {
                        Image(systemName: "tshirt.fill")
                        Text("Patrons")
                    }
                }
            
            NewProductChoosePatternView()
                .tabItem{
                    VStack {
                        Image(systemName: "arrowtriangle.right.circle")
                        Text("Nouveau produit")
                    }
                }
            
            ProfileView(loggedIn: $loggedIn)
                .tabItem{
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Profil")
                    }
                }
            
        }
        .environmentObject(StoreModel())
        .environmentObject(FabricModel())
        .environmentObject(PatternModel())

        
        
    }
}

