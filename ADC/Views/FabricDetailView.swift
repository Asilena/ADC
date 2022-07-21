//
//  FabricDetailView.swift
//  ADC
//
//  Created by Elisa Berkane on 14/07/2022.
//

import SwiftUI
import MapKit

struct FabricDetailView: View {
    
    @EnvironmentObject var model:FabricModel
    var fabric:Fabric
    
    var body: some View {
        
        ScrollView{
            
            VStack(alignment: .leading) {
                
                
                // MARK: image
                Image(fabric.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(15)
                  
                
                // MARK: general info
                HStack() {
                    
                    Spacer()
                    
                    Image(systemName: "tag")
                    Text(fabric.type)
                    
                    Spacer()

                    Image(systemName: "cart")
                    Text(fabric.source.name)
                    
                    Spacer()

                    Image(systemName: "creditcard")
                    Text(String(FabricModel.CalculateFabricPrice(fabric: fabric)) + " €/m²")
                    
                    Spacer()

                }
                
                Divider()
                
                // MARK: size bought
                VStack(alignment: .leading) {
                    Text("Taille achetée: ")
                        .font(.headline)
                        .padding(.vertical, 1)
                    ForEach (fabric.sizes) { item in
                        Text("• Quantité: " + String(item.quantity))
                        Text("• Largeur: " + String(item.width) + " m")
                        Text("• Longueur: " + String(item.length) + " m")
                        Text("• Surface: " + String(round(100*item.length*item.width)/100.0) + " m2")
                    }
                    
                    
                }
                
                Divider()
                
                
                if fabric.source.type == "physical" {
                    VStack{
                        MapView(lat: fabric.source.latitude ?? 0.0, long: fabric.source.longitude ?? 0.0, title: fabric.source.name)
                            .frame(width: 400, height:300)
                            .cornerRadius(15)
                    }
                }
                
                
            }
            .padding(.horizontal, 10.0)
            
        }
        .onAppear(perform : {model.getDatabaseSizes(fabric: fabric) { size in
            fabric.sizes=size
        }})
        //.onDisappear(perform: {model.sizeListener?.remove()})
        .navigationBarTitle(fabric.name)

        
    }
}






struct FabricDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        //Create dummy fabric and pass into the detail view to get the preview
        let model = FabricModel()
        FabricDetailView(fabric: model.fabricList[0])
        
    }
}
