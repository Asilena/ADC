//
//  HomeView.swift
//  ADC
//
//  Created by Elisa Berkane on 14/07/2022.
//

import SwiftUI
import AVKit

struct HomeView: View {
        
    @EnvironmentObject var model:FabricModel
    @EnvironmentObject var Pmodel:PatternModel

    
    var body: some View {
        
Text("Hello")
    }
    
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(FabricModel())
            .environmentObject(PatternModel())

    }
}
