//
//  NewProductStepsView.swift
//  ADC
//
//  Created by Elisa Berkane on 19/07/2022.
//

import SwiftUI

struct NewProductStepsView: View {
    
    @EnvironmentObject var Pmodel:PatternModel
    @EnvironmentObject var model:FabricModel

    var body: some View {
        
        VStack {
            Text("Tissus choisis:")
            
            
        }
    }
}

struct NewProductStepsView_Previews: PreviewProvider {
    static var previews: some View {
        NewProductStepsView()
            .environmentObject(FabricModel())
            .environmentObject(PatternModel())
    }
}
