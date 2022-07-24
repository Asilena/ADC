//
//  ContentView.swift
//  ADC
//
//  Created by Elisa Berkane on 10/07/2022.
//

import SwiftUI


// Create home page

struct FabricListView: View {
    
    @EnvironmentObject var model:UserModel

    
    @State var isAddViewShowing = false
    
    var body: some View {
        
        VStack {
            
            Text("Tissus")
                .bold()
                .padding(.top, 40)
                .font(.largeTitle)
            Text(String(model.fabricList.count))
            
            NavigationView {
                
                    
                    
                        
                            List{
                            ForEach(Array(model.fabricList.enumerated()), id:\.offset) { index, f in
                                
                                
                                NavigationLink(
                                    destination: FabricDetailView(index: index),
                                    label: {
                                        // MARK: row item
                                        HStack(spacing: 20.0) {
                                            Image(f.image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 70, height: 70, alignment: .center)
                                                .clipped()
                                                .cornerRadius(5)
                                            
                                            VStack(alignment: .leading) {
                                                Text(f.name)
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.black)
                                                
                                                if f.source.type == "physical" {
                                                    Text(f.source.name + " - " + f.source.city!)
                                                        .font(.subheadline)
                                                        .foregroundColor(.black)
                                                    
                                                }
                                                if f.source.type == "online" {
                                                    Text(f.source.name)
                                                        .font(.subheadline)
                                                        .foregroundColor(.black)
                                                    
                                                }
                                            }
                                            
                                            
                                            
                                            
                                        }
                                    })
                                
                            }
                            .onDelete(perform: model.deleteFabric)
                            }
                            
                            
                        
                        
                        
                    
                    
                    
                
               
                
                
            }
            .navigationBarHidden(true)
            .padding(.leading)
            // MARK: Add
            
            // Add card button
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
                NewFabricView()
            }
            
            
            
        }
        
    }
    
    
    
}
