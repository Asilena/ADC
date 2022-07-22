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
        
    }
    
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
            print("got to fabric listener")
            if error == nil && snapshot != nil {
                
                
                
                // Loop through the documents returned
                for doc in snapshot!.documents {
                    // Create a new Fabric instance
                    var f = Fabric()
                    
                    // Parse data
                    f.id = doc.documentID as? String ?? UUID().uuidString
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
                    s.id = doc.documentID as? String ?? UUID().uuidString
                    s.quantity = doc["quantity"] as? Int ?? 0
                    s.width = doc["width"] as? Double ?? 0.0
                    s.length = doc["length"] as? Double ?? 0.0
                    s.price = doc["price"] as? Double ?? 0.0
                    
                    
                    
                    // Add to array
                    list.append(s)
                    
                }
                
            }
            
            completionHandler(list)
            
        }
        
    }
    
    func deleteFabric(fabric:Fabric) {
        
        // Specify document to delete
        db.collection("fabrics").document(fabric.id).delete { error in
            //Check if successful
            if error == nil{
                // No errors
                DispatchQueue.main.async {
                    self.fabricList.removeAll { fabrics in
                        // Checl for fabric to remove
                        return fabrics.id == fabric.id
                    }
                }
                
            }
        }
        
    }
    
    func addFabric(name:String, type:String, sizes: [FabricSize]) {
        
        // Add document to collection
        db.collection("fabrics").addDocument(data: ["name":name, "type":type]) { error in
            // Check for errors
            if error == nil {
                // No errors
                self.getDatabaseFabrics { fabrics in
                    self.fabricList = fabrics
                }
            }
            else {
                // Handle the error
            }
        }
        
        
    }
    
    func addSize(fabric:Fabric, length:Double, width:Double, quantity:Int, price:Double) {
        // Add document to collection
        db.collection("fabrics").document(fabric.id).collection("sizes").addDocument(data: ["length":length, "width":width, "price":price, "quantity":quantity])
    }
    
    
    
}




