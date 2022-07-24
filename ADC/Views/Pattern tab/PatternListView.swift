////
////  PatternListView.swift
////  ADC
////
////  Created by Elisa Berkane on 14/07/2022.
////
//
//import SwiftUI
//
//struct PatternListView: View {
//
//    @EnvironmentObject var Pmodel:PatternModel
//
//
//    var body: some View {
//
//        NavigationView {
//
//            VStack (alignment: .leading) {
//
//                Text("Patrons")
//                    .bold()
//                    .padding(.top, 40)
//                    .font(.largeTitle)
//
//
//                ScrollView {
//
//                    LazyVStack (alignment: .leading) {
//
//                        ForEach(Pmodel.patternList) { p in
//                            NavigationLink(
//                                destination: PatternDetailView(pattern: p),
//                                label: {
//                                    // MARK: row item
//                                    HStack(spacing: 20.0) {
//                                        Image(p.image)
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(width: 50, height: 50, alignment: .center)
//                                            .clipped()
//                                            .cornerRadius(5)
//                                        VStack (alignment: .leading) {
//                                            Text(p.name)
//                                                .foregroundColor(.black)
//                                                .font(.headline)
//                                                .fontWeight(.bold)
//                                            HStack {
//                                                Image(systemName: "clock")
//                                                    .foregroundColor(.black)
//                                                Text(String(PatternModel.getTime(pattern: p, quantity: 1)))
//                                                    .foregroundColor(.black)
//                                                    .font(.subheadline)
//
//
//                                            }
//                                        }
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
//    }
//}
//
//struct PatternListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PatternListView()
//            .environmentObject(PatternModel())
//    }
//}
