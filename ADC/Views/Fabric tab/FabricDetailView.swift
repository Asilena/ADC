//
//  FabricDetailView.swift
//  ADC
//
//  Created by Elisa Berkane on 14/07/2022.
//

import SwiftUI
import MapKit

struct FabricDetailView: View {
    @State var isAddViewShowing = false


    @EnvironmentObject var model:UserModel
    var index:Int
    
    var body: some View {
        
        if index < model.fabricList.count {
        ScrollView{
            
            VStack(alignment: .leading) {
                
                
                // MARK: image
                Image(model.fabricList[index].image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(15)
                  
                
                // MARK: general info
                HStack() {
                    
                    Spacer()
                    
                    Image(systemName: "tag")
                    Text(model.fabricList[index].type)
                    
                    Spacer()

                    Image(systemName: "cart")
                    Text(model.fabricList[index].source.name)
                    
                    Spacer()

                    Image(systemName: "creditcard")
                    Text(String(FabricModel.CalculateFabricPrice(fabric: model.fabricList[index])) + " €/m²")
                    
                    Spacer()

                }
                
                Divider()
                
                // MARK: size bought
                VStack(alignment: .leading) {
                    Text("Taille achetée: ")
                        .font(.headline)
                        .padding(.vertical, 1)
                    ForEach (model.fabricList[index].sizes) { item in
                        Text("• Quantité: " + String(item.quantity))
                        Text("• Largeur: " + String(item.width) + " m")
                        Text("• Longueur: " + String(item.length) + " m")
                        Text("• Surface: " + String(round(100*item.length*item.width)/100.0) + " m2")
                    }
                    
                    
                }
                
                Divider()
                
                
                if model.fabricList[index].source.type == "physical" {
                    VStack{
                        MapView(lat: model.fabricList[index].source.latitude ?? 0.0, long: model.fabricList[index].source.longitude ?? 0.0, title: model.fabricList[index].source.name)
                            .frame(width: 400, height:300)
                            .cornerRadius(15)
                    }
                }
                
             
                
                // MARK: Instructions
                
                // Instruction card button
                Button {
                    // Show step detail sheet
                    self.isAddViewShowing = true
                } label: {
                    Image(systemName: "plus.circle")
                        .padding()
                        .frame(height:50)
                    
                }
                .sheet(isPresented: $isAddViewShowing) {
                    // Show the step details
                    NewSizeView(fabric: model.fabricList[index])
                }
                
            }
            .padding(.horizontal, 10.0)
            
        }
        }

        
    }
}






