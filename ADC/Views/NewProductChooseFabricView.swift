//
//  NewProductChooseFabricView.swift
//  ADC
//
//  Created by Elisa Berkane on 18/07/2022.
//

import SwiftUI

struct NewProductChooseFabricView: View {
    
    var chosenPattern: Pattern
    
    @EnvironmentObject var Smodel:StoreModel
    @EnvironmentObject var model:FabricModel
    @EnvironmentObject var Pmodel:PatternModel
    
    // @State var selectedFabricIndexes:Int?
    // @State var submitted = false
    
    
    var body: some View {
        
        
        NavigationView {
            
            VStack {
            
                Form {
                Section("Choisir tissus") {
                    // For each type of fabric
                    ForEach(0..<chosenPattern.fabricsNeeded.count, id: \.self) {index in
                        
                        Picker(chosenPattern.fabricsNeeded[index].type, selection: $Pmodel.chosenFabrics[index]) {
                            
                                
                            ForEach(0..<model.fabricList.count,  id: \.self) { fabricIndex in
                                    HStack(spacing: 20.0) {
                                        Image(model.fabricList[fabricIndex].image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 70, height: 70, alignment: .center)
                                            .clipped()
                                            .cornerRadius(5)
                                        
                                        VStack(alignment: .leading) {
                                            Text(model.fabricList[fabricIndex].name)
                                        }
                                        
                                        Spacer()
                                    }.tag(fabricIndex)
                                }

                                
                            
                        }
                    }
                }
            }
            
                NavigationLink(
                    destination: NewProductStepsView(),
                    label: {
                    Text("Text")
                })

                
            }
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //        VStack(alignment: .leading) {
        //
        //            // Fabric we are asking for
        //            Text("Choisir un " + chosenPattern.fabricsNeeded[Pmodel.currentFabricSelectionIndex].type)
        //                .padding()
        //
        //            ScrollView {
        //                VStack(alignment: .leading) {
        //                    ForEach (0..<model.fabricList.count, id: \.self) { index in
        //
        //                        Button {
        //                            // Track the selected index
        //                            selectedFabricIndexes.append(index)
        //
        //                            submitted = true
        //
        //                        } label: {
        //
        //                            ZStack {
        //
        //                                Rectangle()
        //                                    .foregroundColor(index == selectedFabricIndexes[Pmodel.currentFabricSelectionIndex+1] ? .gray : .white)
        //                                    .cornerRadius(10)
        //                                    .shadow(color: .gray, radius: 3, x: 5, y: 5)
        //
        //                                HStack(spacing: 20.0) {
        //                                    Image(model.fabricList[index].image)
        //                                        .resizable()
        //                                        .scaledToFill()
        //                                        .frame(width: 70, height: 70, alignment: .center)
        //                                        .clipped()
        //                                        .cornerRadius(5)
        //
        //                                    VStack(alignment: .leading) {
        //                                        Text(model.fabricList[index].name)
        //                                    }
        //
        //                                    Spacer()
        //                                }
        //                                .padding()
        //
        //                            }
        //
        //                        }
        //                        //.disabled(submitted)
        //
        //
        //
        //                    }
        //                }
        //                .accentColor(.black)
        //                .padding()
        //            }
        //
        //            // Submit Button
        //            Button {
        //                //
        //
        //            } label: {
        //
        //                ZStack {
        //
        //                    Rectangle()
        //                        .cornerRadius(10)
        //                        .frame(height: 50)
        //                        .padding()
        //
        //                    Text("Next")
        //                        .bold()
        //                        .foregroundColor(Color.white)
        //                }
        //                .padding()
        //            }
        //            .disabled(!submitted)
        //
        //        }
    }
}

struct NewProductChooseFabricView_Previews: PreviewProvider {
    static var previews: some View {
        let Pmodel = PatternModel()
        NewProductChooseFabricView(chosenPattern: Pmodel.patternList[0])
            .environmentObject(FabricModel())
            .environmentObject(PatternModel())
    }
}
