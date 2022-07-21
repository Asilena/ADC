//
//  PatternModel.swift
//  ADC
//
//  Created by Elisa Berkane on 14/07/2022.
//

import Foundation

class PatternModel: ObservableObject {
    
    // List of patterns
    @Published var patternList = [Pattern]()
    
    // Current fabric that needs to be selected
    var currentFabricSelectionIndex = 0
    
    // Selected fabrics
    @Published var chosenFabrics:[Int] = [0]

    
    init() {
        
        // Create an instance of data service and get the data
        //self.patternList = DataService.getLocalDataPattern()
        //getRemoteData()
        
    }
    
//    func getRemoteData() {
//            
//            // String path
//            let urlString = "https://asilena.github.io/ADCData/patternData.json"
//            
//            // Create a url object
//            let url = URL(string: urlString)
//            
//            guard url != nil else {
//                // Couldn't create url
//                return
//            }
//            
//            // Create a URLRequest object
//            let request = URLRequest(url: url!)
//            
//            // Get the session and kick off the task
//            let session = URLSession.shared
//            
//            let dataTask = session.dataTask(with: request) { (data, response, error) in
//                
//                // Check if there's an error
//                guard error == nil else {
//                    // There was an error
//                    return
//                }
//                
//                do {
//                    // Create json decoder
//                    let decoder = JSONDecoder()
//                
//                    // Decode
//                    let list = try decoder.decode([Pattern].self, from: data!)
//                   
//                    DispatchQueue.main.async {
//
//                        self.patternList = list
//                    
//                    // Add the unique IDs
//                    for p in self.patternList {
//                        p.id = UUID()
//                        // Add IDs to size of fabrics
//                        for d in p.fabricsNeeded {
//                            d.id = UUID()
//                        }
//                        if p.claspsNeeded != nil {
//                            for d in p.claspsNeeded! {
//                                d.id = UUID()
//                            }
//                        }
//                    }
//                    }
//                    
//                    
//                    // Add the unique IDs
//                    for f in self.patternList {
//                        f.id = UUID()
//                    }
//                    
//                }
//                catch {
//                    // Couldn't parse json
//                }
//            }
//            
//            // Kick off data task
//            dataTask.resume()
//            
//        }

    
    // Calculate fabric needed for a pattern
    static func getSize(fabric:FabricNeeded, quantity:Int) -> Int {
        
        // Calculate size needed
        let length = fabric.length * quantity
        
        // Return size
        return length
    }
    
    // Calculate time needed for a pattern
    static func getTime(pattern:Pattern, quantity:Int) -> String {
        
        // Calculate time needed
        let time = pattern.time * quantity
        var totalTime:String
        
        // Convert to hours if needed
        if time > 60 {
            totalTime = String(time/60) + "h" + String(time%60)
        }
        else {
            totalTime = String(time) + " minutes"
        }
        
        // Return time
        return totalTime
    }
    
    // Calculate clasps needed for a pattern
    static func getClasps(clasp:ClaspsNeeded, quantity:Int) -> Int {
        
        // Calculate size needed
        let totalQuantity = clasp.quantity * quantity
        
        // Return size
        return totalQuantity
    }
    
    func beginFabricSelection(pattern:Pattern) {
        
        // Set the current fabric being selected
        currentFabricSelectionIndex = 0
        
        // Initialize chosen fabrics array to zeros
        chosenFabrics = [Int](repeating: 0, count: pattern.fabricsNeeded.count)
        
    }
    
    func nextFabricSelection() {
        
        // Advance the fabric selection index
        currentFabricSelectionIndex += 1
        
        // Check if it's still in range
        //if currentFabricSelectionIndex <
        
        
    }
    
}
