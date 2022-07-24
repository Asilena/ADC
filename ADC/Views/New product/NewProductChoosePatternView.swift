////
////  NewProductChoosePatternView.swift
////  ADC
////
////  Created by Elisa Berkane on 18/07/2022.
////
//
//import SwiftUI
//
//struct NewProductChoosePatternView: View {
//    
//    @EnvironmentObject var Pmodel:PatternModel
//    
//    @State var patternChosen = false
//    
//    var body: some View {
//        
//        NavigationView {
//            
//            VStack (alignment: .leading) {
//                
//                Text("Choose pattern you want to do")
//                
//                ScrollView {
//                    
//                    LazyVStack (alignment: .leading) {
//                        
//                        ForEach(Pmodel.patternList) { p in
//                            NavigationLink(
//                                destination: { NewProductChooseFabricView(chosenPattern:p)
//                                    .onAppear(perform: {Pmodel.beginFabricSelection(pattern: p)})
//                                },
//                                label: {
//                                // MARK: row item
//                                    ZStack {
//                                        
//                                        HStack(spacing: 20.0) {
//                                            Image(p.image)
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(width: 75, height: 75, alignment: .center)
//                                                .clipped()
//                                                .cornerRadius(5)
//                                            VStack (alignment: .leading) {
//                                                Text(p.name)
//                                                    .foregroundColor(.black)
//                                                    .font(.headline)
//                                                    .fontWeight(.bold)
//                                                HStack {
//                                                    Image(systemName: "clock")
//                                                        .foregroundColor(.black)
//                                                    Text(String(PatternModel.getTime(pattern: p, quantity: 1)))
//                                                        .foregroundColor(.black)
//                                                        .font(.subheadline)
//                                                    
//                                                    
//                                                }
//                                            }
//                                            Spacer()
//                                        }
//                                        
//                                    }
//                                })
//                            
//                            
//                        }
//                        
//                    }
//                    
//                    
//                }
//            }
//            .navigationBarHidden(true)
//            .padding(.leading)
//            
//        }
//        
//        
//        
//        
//        
//        
//    }
//}
//
//
//
//struct NewProductChoosePatternView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewProductChoosePatternView()
//            .environmentObject(PatternModel())
//        
//    }
//}
