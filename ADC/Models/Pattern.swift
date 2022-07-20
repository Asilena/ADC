//
//  Pattern.swift
//  ADC
//
//  Created by Elisa Berkane on 14/07/2022.
//

import Foundation

class Pattern: Identifiable, Decodable, ObservableObject {
    
    var id:UUID?
    var name:String
    var source:String
    var image:String
    var time:Int
    var fabricsNeeded:[FabricNeeded]
    var claspsNeeded:[ClaspsNeeded]?
    var steps:[String]?
    var photos:[String]?
    var video:String?

}

class FabricNeeded: Identifiable, Decodable, ObservableObject {
    
    var id:UUID?
    var type:String
    var length:Int
    var width:Int
    
}

class ClaspsNeeded: Identifiable, Decodable, ObservableObject {
    
    var id:UUID?
    var type:String
    var quantity:Int
    
}
