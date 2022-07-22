//
//  DoneButton.swift
//  ADC
//
//  Created by Elisa Berkane on 22/07/2022.
//

import SwiftUI

struct DoneButton: View {
        
    var body: some View {

        ZStack{
            
            Rectangle()
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding()
                .frame(height:50)
            
            Text("Terminé")
            
        }



    }
}

