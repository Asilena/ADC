//
//  FabricModel.swift
//  ADC
//
//  Created by Elisa Berkane on 12/07/2022.
//

import Foundation
import SwiftUI

class FabricModel: ObservableObject {
    
    @Published var fabricList = [Fabric]()
    
    init() {
        
        // Create an instance of data service and get the data
        //self.fabricList = DataService.getLocalDataFabric()
        //self.fabricList = DataService.getRemoteFabricData()
        
        getRemoteData()
        
    }
    
    
    func getRemoteData() {
            
            // String path
            let urlString = "https://asilena.github.io/ADCData/fabricData.json"
            
            // Create a url object
            let url = URL(string: urlString)
            
            guard url != nil else {
                // Couldn't create url
                return
            }
            
            // Create a URLRequest object
            let request = URLRequest(url: url!)
            
            // Get the session and kick off the task
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                // Check if there's an error
                guard error == nil else {
                    // There was an error
                    return
                }
                
                do {
                    // Create json decoder
                    let decoder = JSONDecoder()
                
                    // Decode
                    let list = try decoder.decode([Fabric].self, from: data!)
                    
                    DispatchQueue.main.async {
                        self.fabricList = list
                        
                        // Add the unique IDs
                        for f in self.fabricList {
                            f.id = UUID()
                        }
                    }
                    
                    
                   
                    
                }
                catch {
                    // Couldn't parse json
                }
            }
            
            // Kick off data task
            dataTask.resume()
            
        }
    
    
    // Calculate average fabric price
    static func CalculateFabricPrice(fabric:Fabric) -> Float {
        
        var priceM2:[Float] = [0.0]
        
        // Calculate price per m2 for each sizes bought
        for item in fabric.sizes {
            priceM2.append(item.price/(item.length*item.width))
        }
        
        priceM2.removeFirst()
        
        // Return price per m2
        let meanPrice = priceM2.reduce(0.0) {
            return $0 + $1/Float(priceM2.count)
        }
        return  round(100*meanPrice)/100.0
        }
        
    }
    
