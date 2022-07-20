//
//  PatterStepView.swift
//  ADC
//
//  Created by Elisa Berkane on 15/07/2022.
//

import SwiftUI
import AVKit
import AVFoundation
import YouTubePlayerKit


struct PatternStepView: View {
    
    var pattern:Pattern
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
                        
            Text("Instructions")
                .bold()
                .padding(.leading)
                .padding(.top, 40)
                .padding(.bottom, 10)
                .font(.largeTitle)
            
            if pattern.steps != nil {
            
                GeometryReader {geo in
                
                TabView {
                    
                    // Loop through each fabric
                    ForEach (0..<pattern.steps!.count, id: \.self) { index in
                        
                        
                        // Fabric card
                        
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            
                            VStack (spacing:0){
                                
                                Text("Etape " + String(index+1))
                                    .font(.headline)
                                    .padding(.all)

                                
                                Image(pattern.photos![index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipped()
                                    .padding(5)

                                
                                Text(pattern.steps![index])
                                    .padding(5)
                                Spacer()
                            }
                        }
                        .frame(width: geo.size.width-40, height: geo.size.height-100, alignment: .center)
                        .cornerRadius(15)
                        .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.6), radius: 10, x: -5, y: 5)
                    }
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                
            }
                
            }
            
            else if pattern.video != nil {
                
                let youTubePlayer: YouTubePlayer = YouTubePlayer(source: .url(String(pattern.video!)))
                YouTubePlayerView(youTubePlayer) { state in
                            // Overlay ViewBuilder closure to place an overlay View
                            // for the current `YouTubePlayer.State`
                            switch state {
                            case .idle:
                                ProgressView()
                            case .ready:
                                EmptyView()
                            case .error(let error):
                                Text(verbatim: "YouTube player couldn't be loaded")
                            }
                        }
                .cornerRadius(10)

                
            }
            
        }
            
        
    }
}

struct PatternStepView_Previews: PreviewProvider {
    static var previews: some View {
        //Create dummy pattern and pass into the detail view to get the preview
        let Pmodel = PatternModel()
        PatternStepView(pattern: Pmodel.patternList[0])
    }
}
