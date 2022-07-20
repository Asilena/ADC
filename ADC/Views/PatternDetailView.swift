//
//  PatternView.swift
//  ADC
//
//  Created by Elisa Berkane on 14/07/2022.
//

import SwiftUI

struct PatternDetailView: View {
    
    var pattern:Pattern
    
    @State var selectedQuantity = 1
    @State var isStepViewShowing = false
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            
            ScrollView{
                
                // MARK: Quantity picker
                VStack(alignment: .leading) {
                    
                    Text("Quantité")
                        .font(.headline)
                    
                    Picker("", selection: $selectedQuantity) {
                        Text("1").tag(1)
                        Text("2").tag(2)
                        Text("3").tag(3)
                        Text("5").tag(5)
                        Text("10").tag(10)
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                // MARK: General info
                VStack(alignment: .leading) {
                    Text("Général")
                        .font(.headline)
                        .padding(.vertical, 1)
                    Text("• Source: " + pattern.source)
                    Text("• Temps de réalisation: " + PatternModel.getTime(pattern: pattern, quantity: selectedQuantity))
                    
                    
                    Divider()
                    
                    // MARK: Material needed
                    Text("Tissus")
                        .font(.headline)
                        .padding(.vertical, 1)
                    ForEach (pattern.fabricsNeeded) { item in
                        Text("•  \(item.type): \(String(PatternModel.getSize(fabric: item, quantity: selectedQuantity))) ⨉ \(String(item.width)) cm")
                    }
                    Text("Attaches")
                        .font(.headline)
                        .padding(.vertical, 1)
                    
                    if pattern.claspsNeeded != nil {
                    
                        ForEach (pattern.claspsNeeded!) { item in
                        Text("•  \(item.type): \(String(PatternModel.getClasps(clasp: item, quantity: selectedQuantity)))")
                    }
                    }
                    
                    
                    Divider()
                    
                    
                }
            }
            
            
            
            
            
            // MARK: Instructions
                        
            // Instruction card button
            Button {
                // Show step detail sheet
                self.isStepViewShowing = true
            } label: {
                
                // Instruction card
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(.white)
                    
                    Text("Instructions")
                        .font(.headline)
                
                }
            }
            .sheet(isPresented: $isStepViewShowing) {
                // Show the step details
                PatternStepView(pattern: pattern)
            }
            .buttonStyle(PlainButtonStyle())
            .cornerRadius(15)
            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 5, x: -5, y: 5)
            
            
            
            
            
            
            
        }
        .navigationBarTitle(pattern.name)
        .padding(.horizontal)
        
        
        
        
    }
}





struct PatternDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        //Create dummy pattern and pass into the detail view to get the preview
        let Pmodel = PatternModel()
        PatternDetailView(pattern: Pmodel.patternList[0])
        
    }
}
