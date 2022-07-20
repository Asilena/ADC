//
//  StoreModel.swift
//  ADC
//
//  Created by Elisa Berkane on 17/07/2022.
//

import Foundation

class StoreModel: ObservableObject {
    
    @Published var storeList = [Store]()
    
    init() {
        
        // Create an instance of data service and get the data
        //self.storeList = DataService.getLocalDataStore()
        getRemoteData()
    }
    
    func getRemoteData() {
            
            // String path
            let urlString = "https://asilena.github.io/ADCData/patternData.json"
            
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
                    let list = try decoder.decode([Store].self, from: data!)
                   
                    DispatchQueue.main.async {

                        self.storeList = list
                    
                    // Add the unique IDs
                    for s in self.storeList {
                        s.id = UUID()
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

    
}

