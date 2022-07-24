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
    
    
    
   
    
    static func addFabric(name:String, type:String, sizes: [FabricSize]) {
        let db = Firestore.firestore()
        // Add document to collection
        db.collection("users").document(Auth.auth().currentUser!.uid).collection("Fabrics").addDocument(data: ["name":name, "type":type]) { error in
            // Check for errors
            if error == nil {
                
            }
            else {
                // Handle the error
            }
        }
        
        
    }
    
    //    func addSize(fabric:Fabric, length:Double, width:Double, quantity:Int, price:Double) {
    //        // Add document to collection
    //        db.collection("Fabrics").document(fabric.id).collection("sizes").addDocument(data: ["length":length, "width":width, "price":price, "quantity":quantity])
    //    }
    //
    //
    //
}




