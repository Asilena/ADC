//
//  NewFabricView.swift
//  ADC
//
//  Created by Elisa Berkane on 22/07/2022.
//

import SwiftUI

struct NewFabricView: View {
    
    @EnvironmentObject var model:FabricModel
    
    @State var name:String = ""
    @State var type:String = ""
    @State var priceS:String = ""
    @State var lengthS:String = ""
    @State var widthS:String = ""
    @State var quantityS:String = ""
    
    @State var sizes: [FabricSize] = [FabricSize]()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        
        VStack{
            
            Form {
                Section(header: Text("Général")) {
                    TextField(text: $name) {Text("Nom")}
                    TextField(text: $type) {Text("Type")}
                }
                Section(header: Text("Détails de l'achat")) {
                    TextField(text: $quantityS) {Text("Quantité")}
                    TextField(text: $lengthS) {Text("Longueur")}
                    TextField(text: $widthS) {Text("Largeur")}
                    TextField(text: $priceS) {Text("Prix")}
                    
                }
            }
            
            Button {
                // Convert data to right format
               let quantity = Int(quantityS)
                let price = Double(priceS)
                let length = Double(lengthS)
                let width = Double(widthS)
                
                let sizes = [FabricSize()]
                sizes[0].width = width ?? 0
                sizes[0].price = price ?? 0
                sizes[0].length = length ?? 0
                sizes[0].quantity = quantity ?? 0

                // Add data
                FabricModel.addFabric(name: name, type: type, sizes: sizes)
                //Clear test fields
                name = ""
                type = ""
                // Get rid of view
                presentationMode.wrappedValue.dismiss()
                
            } label: {
                DoneButton()
            }
            
        }
        
    }
}
