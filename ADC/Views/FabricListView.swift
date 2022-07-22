//
//  ContentView.swift
//  ADC
//
//  Created by Elisa Berkane on 10/07/2022.
//

import SwiftUI


// Create home page

struct FabricListView: View {
    
    @EnvironmentObject var Smodel:StoreModel
    @EnvironmentObject var model:FabricModel
    @EnvironmentObject var Pmodel:PatternModel
    
    @State var isAddViewShowing = false
    
    var body: some View {
        
        VStack {
            
            NavigationView {
                
                VStack (alignment: .leading) {
                    
                    Text("Tissus")
                        .bold()
                        .padding(.top, 40)
                        .font(.largeTitle)
                    
                    ScrollView {
                        
                        LazyVStack (alignment: .leading) {
                            
                            ForEach(model.fabricList) { f in
                                
                                Divider()
                                
                                NavigationLink(
                                    destination: FabricDetailView(fabric: f),
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
                                                //Text(String(f.sizes[0].price))
                                                
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
                            Divider()
                            
                            
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
                        NewFabricView()
                    }
                }
                .navigationBarHidden(true)
                .padding(.leading)
                
                
            }
            .onAppear(perform : {model.getDatabaseFabrics(completionHandler: { fabrics in
                model.fabricList = fabrics
            })})
            .onDisappear(perform: {model.fabricListener?.remove()})
            
            
            
            
            
        }
        
    }
    
    
    
}
