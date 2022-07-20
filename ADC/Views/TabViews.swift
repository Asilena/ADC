//
//  HomeView.swift
//  ADC
//
//  Created by Elisa Berkane on 14/07/2022.
//

import SwiftUI

struct TabViews: View {
    
    
    var body: some View {
        
        TabView{

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
            
        }
        .environmentObject(StoreModel())
        .environmentObject(FabricModel())
        .environmentObject(PatternModel())

        
        
    }
}


struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabViews()
    }
}
