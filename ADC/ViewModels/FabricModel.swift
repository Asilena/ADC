//
//  FabricModel.swift
//  ADC
//
//  Created by Elisa Berkane on 12/07/2022.
//

import Foundation
import SwiftUI
import Firebase

class FabricModel: ObservableObject {
    
    @Published var fabricList = [Fabric]()
    let db = Firestore.firestore()
    var fabricListener: ListenerRegistration?
    var sizeListener: ListenerRegistration?

    init() {
        
        //getRemoteData()
        
        // Get database fabrics
        //getDatabaseFabrics()
        
        
        
        
    }
    
    
    //    func getRemoteData() {
    //
    //        // String path
    //        let urlString = "https://asilena.github.io/ADCData/fabricData.json"
    //
    //        // Create a url object
    //        let url = URL(string: urlString)
    //
    //        guard url != nil else {
    //            // Couldn't create url
    //            return
    //        }
    //
    //        // Create a URLRequest object
    //        let request = URLRequest(url: url!)
    //
    //        // Get the session and kick off the task
    //        let session = URLSession.shared
    //
    //        let dataTask = session.dataTask(with: request) { (data, response, error) in
    //
    //            // Check if there's an error
    //            guard error == nil else {
    //                // There was an error
    //                return
    //            }
    //
    //            do {
    //                // Create json decoder
    //                let decoder = JSONDecoder()
    //
    //                // Decode
    //                let list = try decoder.decode([Fabric].self, from: data!)
    //
    //                DispatchQueue.main.async {
    //                    self.fabricList = list
    //
    //                    // Add the unique IDs
    //                    for f in self.fabricList {
    //                        f.id = UUID()
    //                    }
    //                }
    //
    //
    //
    //
    //            }
    //            catch {
    //                // Couldn't parse json
    //            }
    //        }
    //
    //        // Kick off data task
    //        dataTask.resume()
    //
    //    }
    
    
    // Calculate average fabric price
    static func CalculateFabricPrice(fabric:Fabric) -> Double {
        
        var priceM2:[Double] = [0.0]
        
        // Calculate price per m2 for each sizes bought
        for item in fabric.sizes {
            priceM2.append(item.price/(item.length*item.width))
        }
        
        priceM2.removeFirst()
        
        // Return price per m2
        let meanPrice = priceM2.reduce(0.0) {
            return $0 + $1/Double(priceM2.count)
        }
        return  round(100*meanPrice)/100.0
    }
    
    func getDatabaseFabrics(completionHandler: @escaping ([Fabric]) -> Void) {
        // Create an array of fabrics
        var list = [Fabric]()
        //Specify path
        let collection = db.collection("fabrics")
        
        // Get documents
        self.fabricListener = collection.addSnapshotListener { snapshot, error in
            
            if error == nil && snapshot != nil {
                
               
                
                // Loop through the documents returned
                for doc in snapshot!.documents {
                    // Create a new Fabric instance
                    var f = Fabric()
                    
                    // Parse data
                    f.id = doc["id"] as? String ?? UUID().uuidString
                    f.type = doc["type"] as? String ?? ""
                    f.image = doc["image"] as? String ?? ""
                    f.name = doc["name"] as? String ?? ""
                    f.source = doc["source"] as? Store ?? Store()
                    self.getDatabaseSizes(fabric: f, completionHandler: { size in
                        f.sizes = size
                    })
                    
                    
                    // Add to array
                    //var sizeList = [FabricSize]()

                    //Specify path
                   // let sizecollection = self.db.collection("fabrics").document(f.id).collection("sizes")

                    // Get documents
                    
//                    sizecollection.getDocuments { sizeSnapshot, sizeError in
//                        if sizeError == nil && sizeSnapshot != nil {
//                            for sizeDoc in sizeSnapshot!.documents {
//                                var s = FabricSize()
//                                s.price = sizeDoc["price"] as? Double ?? 10
//                                sizeList.append(s)
//                            }
//                        }

//
//                    }
                    
                   // f.sizes = sizeList
                    list.append(f)

                }
                
                // Assign the fabrics to the published property
//                DispatchQueue.main.async {
//                    self.fabricList = list
//
//
//                }
                
                
            }
            completionHandler(list)
            
        }
        
    }
    
    func getDatabaseSizes(fabric: Fabric, completionHandler: @escaping ([FabricSize]) -> Void) {
        var list = [FabricSize]()

        //Specify path
        let collection = db.collection("fabrics").document(fabric.id).collection("sizes")

        // Get documents
        collection.getDocuments { (snapshot, error) in

            if error == nil && snapshot != nil {
                
                // Create an array of fabrics
                // Loop through the documents returned
                for doc in snapshot!.documents {
                    
                    // Create a new Fabric instance
                    var s = FabricSize()
                    
                    // Parse data
                    s.id = doc["id"] as? String ?? UUID().uuidString
                    s.quantity = doc["quantity"] as? Int ?? 0
                    s.width = doc["width"] as? Double ?? 0.0
                    s.length = doc["length"] as? Double ?? 0.0
                    s.price = doc["price"] as? Double ?? 0.0
                    
                    
                    
                    // Add to array
                    list.append(s)
                    print(list[0].width)
                
                }
                
            }
            
            completionHandler(list)
            
        }
        
    }
    
    
//    func getDataBaseSizes(fabric:Fabric) {
//
//        // Parse the fabric size
//        let sizeCollection = db.collection("fabrics").document(fabric.id).collection("sizes")
//        print("Collection:")
//        print(sizeCollection)
//        sizeCollection.getDocuments { sizeSnapshot, sizeError in
//            if sizeError == nil && sizeSnapshot != nil {
//                print("Snapshot:")
//                print(sizeSnapshot)
//                var sizeList = [FabricSize]()
//                print("Documents:")
//                print(sizeSnapshot?.documents)
//
//                for sizeDoc in sizeSnapshot!.documents {
//                    //print(sizeList)
//                    var s = FabricSize()
//                    //print("size price of " + fabric.name)
//                    s.id = sizeDoc["id"] as? String ?? UUID().uuidString
//                    s.length = sizeDoc["length"] as? Double ?? 0
//                    s.width = sizeDoc["width"] as? Double ?? 0.0
//                    s.price = sizeDoc["price"] as? Double ?? 0.0
//                    s.quantity = sizeDoc["quantity"] as? Int ?? 0
//                    print(sizeDoc["id"])
//                    print(s.id)
//                    sizeList.append(s)
//
//                    //print(s.price)
//
//                }
//
//                // Assign the fabrics to the published property
//                DispatchQueue.main.async {
//
//                    for (index, f) in self.fabricList.enumerated() {
//                        if f.id == fabric.id {
//                            self.fabricList[index].sizes = sizeList
//                        }
//
//                    }
//                }
//
//
//            }
//            //print("finish " + fabric.name)
//
//        }
//
//    }
    
}

