//
//  DataService.swift
//  ADC
//
//  Created by Elisa Berkane on 13/07/2022.
//

import Foundation

class DataService {
    
    //Parse local fabricData JSON file
    static func getLocalDataFabric() -> [Fabric] {
        
        
        // Get url path to JSON file within the app bundle
        let pathString = Bundle.main.path(forResource: "fabricData", ofType: "json")
        
        // Check if path was found
        guard pathString != nil else {
            return [Fabric]()
        }
        
        // Create url object
        let url = URL(fileURLWithPath: pathString!)
        
        do {
            // Create a data object
            let data = try Data(contentsOf: url)
            
            // Decode the data with a JSON decoder
            let decoder = JSONDecoder()
            
            do {
                let fabricData = try decoder.decode([Fabric].self, from: data)
                
                // Add the unique IDs
                for f in fabricData {
                    f.id = UUID()
                }
                
                // Return the fabrics
                return fabricData
            }
            catch {
                // Error with parsing JSON
                print(error)
            }
            
        }
        catch {
            // Error with getting the data
            print(error)
        }
        
        return [Fabric]()
        
    }
    
    //Parse local patternData JSON file
    static func getLocalDataPattern() -> [Pattern] {
        
        
        // Get url path to JSON file within the app bundle
        let pathString = Bundle.main.path(forResource: "patternData", ofType: "json")
        
        // Check if path was found
        guard pathString != nil else {
            return [Pattern]()
        }
        
        // Create url object
        let url = URL(fileURLWithPath: pathString!)
        
        do {
            // Create a data object
            let data = try Data(contentsOf: url)
            
            // Decode the data with a JSON decoder
            let decoder = JSONDecoder()
            
            do {
                let patternData = try decoder.decode([Pattern].self, from: data)
                
                // Add the unique IDs
                for p in patternData {
                    p.id = UUID()
                    // Add IDs to size of fabrics
                    for d in p.fabricsNeeded {
                        d.id = UUID()
                    }
                    if p.claspsNeeded != nil {
                        for d in p.claspsNeeded! {
                            d.id = UUID()
                        }
                    }
                }
                
                // Return the patterns
                return patternData
            }
            catch {
                // Error with parsing JSON
                print(error)
            }
            
        }
        catch {
            // Error with getting the data
            print(error)
        }
        
        return [Pattern]()
        
    }
    
    //Parse local storeData JSON file
    static func getLocalDataStore() -> [Store] {
        
        
        // Get url path to JSON file within the app bundle
        let pathString = Bundle.main.path(forResource: "storeData", ofType: "json")
        
        // Check if path was found
        guard pathString != nil else {
            return [Store]()
        }
        
        // Create url object
        let url = URL(fileURLWithPath: pathString!)
        
        do {
            // Create a data object
            let data = try Data(contentsOf: url)
            
            // Decode the data with a JSON decoder
            let decoder = JSONDecoder()
            
            do {
                let storeData = try decoder.decode([Store].self, from: data)
                
                // Add the unique IDs
                for s in storeData {
                    s.id = UUID()
                }
                
                // Return the stores
                return storeData
            }
            catch {
                // Error with parsing JSON
                print(error)
            }
            
        }
        catch {
            // Error with getting the data
            print(error)
        }
        
        return [Store]()
        
    }
    
    
    
    static func getRemoteFabricData() -> [Fabric] {
        
        

        print("Step 1")

        // String path
        let urlString = "https://asilena.github.io/ADCData/fabricData.json"
        
        // Create url object
        let url = URL(string: urlString)
        
        guard url != nil else {
            // Couldn't create url
            return []
        }
        
        // Create a url request object
        let request = URLRequest(url: url!)
        
        // Get the session and kick off the task
        let session = URLSession.shared
        

        var fabricData: [Fabric] = []
        print("Step 2")
        print(fabricData)
       
        let dataTask = session.dataTask(with: request) { data, response, error in
            print("Step 3")
            print(fabricData)

            // Check if there is an error
            guard error == nil else {
                //There was an error
                return
            }
            
            // Create json decoder
            let decoder = JSONDecoder()
            
            do{
                print("Step 4")
                print(fabricData)

                // Decode
                fabricData = try decoder.decode([Fabric].self, from: data!)

                print("Step 5")
                print(fabricData)
                // Add the unique IDs
                for f in fabricData {
                    f.id = UUID()
                }
            }
            catch {
                // Error with parsing JSON
                print(error)
            }
        }
        print("Step 5")
        print(fabricData)

        // Kick off the data task
        dataTask.resume()
        
        print("Step 6")
        print(fabricData)
        
        return fabricData
        
        
    }
    
    
}
