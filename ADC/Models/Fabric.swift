//
//  Fabric.swift
//  ADC
//
//  Created by Elisa Berkane on 12/07/2022.
//

import Foundation

struct Fabric: Identifiable, Hashable, Equatable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Fabric, rhs: Fabric) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id:String = ""
    var name:String = ""
    var source:Store = Store()
    var image:String = ""
    var type:String = ""
    var sizes:[FabricSize] = []
    
    
}

class FabricSize: Identifiable, Decodable, ObservableObject {
    
    var id:String = ""
    var quantity:Int = 0
    var length:Double = 0.0
    var width:Double = 0.0
    var price:Double = 0.0
    
}

class Store: Identifiable, Decodable, ObservableObject {
    
    var id:String = ""
    var name:String = ""
    var city:String? = ""
    var type:String = ""
    var latitude:Double? = 0.0
    var longitude:Double? = 0.0
    var website:String? = ""
    
}

