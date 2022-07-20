//
//  Fabric.swift
//  ADC
//
//  Created by Elisa Berkane on 12/07/2022.
//

import Foundation

class Fabric: Identifiable, Decodable, ObservableObject {
    
    var id:UUID?
    var name:String
    var source:Store
    var image:String
    var type:String
    var sizes:[FabricSize]

    
}

class FabricSize: Identifiable, Decodable, ObservableObject {
    
    var id:UUID?
    var quantity:Int
    var length:Float
    var width:Float
    var price:Float
    
}
